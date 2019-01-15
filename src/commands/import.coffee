{Command, flags} = require('@oclif/command')
Sharinpix = require('sharinpix-js')
csv = require('csvtojson')
fs = require('fs')
queue = require('./queue')
ndjson = require('ndjson')
request = require('request-promise-native')
tmp = require('tmp')
mmm = require('mmmagic')
md5File = require('md5-file')
download = (url)->
  console.log "Download #{url}"
  new Promise (resolve, reject)->
    filename = tmp.tmpNameSync()
    request(url)
      .on('end', ->
        resolve(filename)
      )
      .on('error', (err)->
        reject(err)
      )
      .pipe(fs.createWriteStream(filename))

extract_infos = (filename)->
  {
    md5: md5File.sync(filename),
    mime_type: await new Promise((resolve, reject)->
      magic = new mmm.Magic(mmm.MAGIC_MIME_TYPE)
      magic.detectFile(filename, (err, res)->
        reject(err) if err
        resolve(res)
      )
    ),
    size: fs.statSync(filename).size,
  }
upload = (obj)->
  path = await download(obj.url)
  filename = obj.filename || 'img.jpg' # TODO !!
  infos = await extract_infos(path)
  console.log infos

  # await Sharinpix.get_instance().upload_stream({
  #   name: filename,
  #   type: infos.mime_type,
  #   size: infos.size,
  #   file: fs.createReadStream(path)
  # })
  storage_file = await Sharinpix.get_instance().post(
    '/storage_files',
    {
      name: filename,
      type: infos.mime_type,
      size: infos.size,
      image_metadatas: obj.metadatas
    }
  )
  console.log fs.statSync(path)
  params = storage_file.upload_parameters
  params.fields.file = fs.createReadStream(path)
  console.log params
  upload_result = await request({
    method: params.method,
    url: params.url,
    formData: params.fields,
  })

  console.log 'UPLOADED !!?'
  console.log res

  res = await Sharinpix.get_instance().put(
    "/storage_files/#{storage_file.id}",
    {
      infos: upload_result
    }
  )

class ImportCommand extends Command
  run: =>
    {flags} = @parse(ImportCommand)
    # If file is a csv we convert it to ndjson
    import_id = (new Date()).getTime()
    if /^.*\.csv$/.test(flags.file)
      console.log 'Converting file'
      ndjsonFilename = "#{flags.file}.ndjson"
      ndjsonFile = fs.openSync(ndjsonFilename, 'w')
      await new Promise (resolve, reject)->
        csv(delimiter: ';')
          .fromFile(flags.file)
          .subscribe((obj)->
            fs.writeSync(ndjsonFile, JSON.stringify(obj)+"\n")
          , reject
          , resolve)
      flags.file = ndjsonFilename
      console.log 'Converted !'

    errors = fs.openSync("#{flags.file}-errors.ndjson", 'w')
    success = fs.openSync("#{flags.file}-success.ndjson", 'w')

    q = new queue
      concurency: 20,
      callback: (input)->
        obj = JSON.parse(JSON.stringify(input))
        obj.import_type ||= 'url'
        obj.metadatas ||= {}
        obj.metadatas.import_id ||= import_id
        if typeof obj.tags == 'string'
          obj.tags = obj.tags.split(',')
        upload(obj).then(->
          console.log 'SUCCESS', input
          fs.writeSync(success,JSON.stringify(input)+"\n")
        , (err)->
          console.log 'error', input, err
          fs.writeSync(errors, JSON.stringify(input)+"\n")
        )
    fs.createReadStream(flags.file)
      .pipe(ndjson.parse())
      .on('data', (data)->
        q.push(data)
      )

    await q.end()

ImportCommand.description = "Import images"

ImportCommand.flags = 
  file: flags.string(
    char: 'f'
    description: 'Path of file to import'
    required: true)

module.exports = ImportCommand
