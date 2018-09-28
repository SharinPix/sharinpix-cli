const { Command, flags } = require('@oclif/command'),
      csv = require('fast-csv'),
      fs = require('fs'),
      _ = require('lodash')

class ImportCommand extends Command {
  async run() {
    return new Promise((resolve,reject)=>{
      const { flags } = this.parse(ImportCommand)
      const file = flags.file

      var readStream = fs.createReadStream(file),
          album_id, url, tags, metadatas, json, errorFlag

      csv
      .fromStream(readStream, {delimiter : ';'})
        .on('data', (data) => {

          [album_id, url, tags, metadatas] = _.values(data)

          if (album_id.length != 18){
            console.error(new Error(`Album Id in ${file} should contain 18 characters!`))
            //reject(Error(`Album Id in ${file} should contain 18 characters!`))
          }

          if (!metadatas || metadatas == ''){
            metadatas ='{}'
          }

          try{
            json = JSON.parse(metadatas)
          }
          catch(err){
          }
        })
        .on('end', () => {
          this.log(`Album Id: ${album_id}`)
          this.log(`Album Id length: ${album_id.length}`)
          this.log(`Url: ${url}`)
          this.log(`Tags: ${tags}`)
          this.log(`Metadatas: ${metadatas}`)
          this.log(json)
          resolve()
        })
        .on('error', (err) => {
          console.log(err)
        })
    });
    
  }
}

ImportCommand.description = `SharinPix-Import Command...`

ImportCommand.flags = {
  file: flags.string({ char: 'f', description: `file to read` }),
}

module.exports = ImportCommand
