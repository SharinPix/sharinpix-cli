import {Command, Flags} from '@oclif/core'
import * as fs from 'node:fs'
import { parse }  from 'papaparse'
import axios from "axios"
import * as FormData from "form-data"
import { sign } from 'jsonwebtoken'
import * as path from 'node:path'

interface Record {
    recordId: string
    path: string
    tags: string
    filename: string
}

export default class ImportFile extends Command {
    static description = 'describe the command here'

    static examples = [
        '<%= config.bin %> <%= command.id %>',
    ]

    static flags = {
        path: Flags.string({char: 'p', description: 'path to CSV file', required: true}),
        force: Flags.boolean({char: 'f'}),
    }

    private CONSUMER_KEY: undefined | string;
    private CONSUMER_SECRET: undefined | string;
    private API_URL: undefined | string;

    static args = {}

    public async run(): Promise<void> {
        const {flags} = await this.parse(ImportFile)

        const sharinpixSecret = process.env.SHARINPIX_SECRET_URL

        if (!sharinpixSecret) {
            throw new Error('SHARINPIX_SECRET_URL has not been set.')
        }

        if (!this.fileExists(flags.path)) {
            throw new Error('File not found. Verify path.')
        }

        this.API_URL = 'https://' + sharinpixSecret.split('//')[1].split('@')[1]
        const splitted = sharinpixSecret.split('//')[1].split('@')[0].split(':')
        this.CONSUMER_KEY = splitted[0]
        this.CONSUMER_SECRET = splitted[1]

        const records = await this.readCSV(flags.path)
        for (const record of records) {
            // eslint-disable-next-line no-await-in-loop
            await this.importPhoto(record)
            this.log(`Processed ID: ${record.recordId}, Path: ${record.path}, Tags: ${record.tags}, filename: ${record.filename}`);
        }
    }

    // check if file exists
    public fileExists(path: string): boolean {
        try {
            fs.accessSync(path, fs.constants.F_OK);
            return true;
        } catch {
            return false;
        }
    }

    // read the csv file
    public async readCSV(filePath: string): Promise<Record[]> {
        return new Promise((resolve, reject) => {
            const fileContent = fs.readFileSync(filePath, 'utf8');
            parse<Record>(fileContent, {
                header: true,
                skipEmptyLines: true,
                complete(results: { errors: string | any[]; data: Record[] | PromiseLike<Record[]> }) {
                    if (results.errors.length > 0) {
                        reject(results.errors)
                    } else {
                        resolve(results.data)
                    }
                }
            })
        })
    }

    public async uploadToS3(uploadParameters: {method: string, url: string, fields: any }, filePath: string) {
        const { method, url, fields } = uploadParameters;
      
        // Create a form instance
        const form = new FormData();
      
        // Append all provided fields to the form
        for (const [key, value] of Object.entries(fields)) {
            form.append(key, value as string);
        }
      
        // Append the file last, important for S3
        form.append('file', fs.createReadStream(filePath));
      
        try {
            const response = await axios({
                method,
                url,
                data: form,
                headers: form.getHeaders()  // Set form headers
            });
      
            // If successful, AWS should return a 201 Created
            if (response.status === 201) {
                console.log('Successfully uploaded file to S3.');
                return response
            }

            console.log('Failed to upload file. Status:', response.status);
            return  response

        } catch (error: any) {
            console.error('Error uploading to S3:', error.message);
        }
    }

    public async importPhoto (row: {recordId: string; filename: string; path: string; tags: undefined | string}) {
        const filePath = row.path;

        if (!this.CONSUMER_KEY) { return }
        if (!this.CONSUMER_SECRET) { return }

        let uploadResponse;
        let storageFileResponse;
        if (fs.existsSync(filePath)) {
            const data = {
                "Id": row.recordId,
                "path": `/pagelayout/${row.recordId}`,
                "abilities": {
                    [row.recordId]: {
                        "Access": {
                            "see": true,
                            "image_tag": true,
                            "image_upload": true
                        }
                    }
                },
                "iss": this.CONSUMER_KEY,
                "admin": true
            };

            const jwtEncoded = sign(data, this.CONSUMER_SECRET, {algorithm: "HS256"});

            const fileSize = fs.statSync(filePath).size;
            const fileExtension = path.extname(filePath).split('.')[1];

            const payload = {
                'album_id': row.recordId,
                'name': row.filename,
                'type': fileExtension,
                'size': fileSize,
            };

            const storageFileApiUrl = `${this.API_URL}/storages/default/storage_files`;
            const storageFileUpdateApiUrl = `${this.API_URL}/storage_files`;

            const header = {'Authorization': `Token token="${jwtEncoded}"`};
            const response = await axios.post(storageFileApiUrl, payload, {headers: header});
            const storageFileId = response.data.id;

            uploadResponse = await this.uploadToS3(response.data.upload_parameters, filePath)

            if (!uploadResponse) { return }

            storageFileResponse = await axios.put(`${storageFileUpdateApiUrl}/${storageFileId}`, uploadResponse.data, {headers: header});
            const imageId = storageFileResponse.data.image.id

            // eslint-disable-next-line camelcase
            await axios.post(`${this.API_URL}/tags/${row.tags}/tag_images`, { image_ids: [imageId] }, { headers: header })
        } else {
            console.log(`${filePath} does not exist.`);
        }
    }
}
