const fs = require('fs')
const { Command, flags } = require('@oclif/command')
var _ = require('lodash')
var csv = require('fast-csv')

class ImportCommand extends Command {
  async run() {
    const { flags } = this.parse(ImportCommand)
    const file = flags.file
    
    // csv
    //   .fromPath(file, {headers: false})
    //   .on('data', data => {
    //     this.log(data)
    //   })
    //   .on('end', () => {
        
    //   })

    var readStream = fs.createReadStream(file)

    csv
    .fromStream(readStream, {delimiter : ';'})
      .on('data', (data) => {
        var album_id, url, tags, metadatas
        [album_id, url, tags, metadatas] = _.values(data)
        
        console.log(album_id.length)
      })
      .on('end', () => {
        
      })
  }
}

ImportCommand.description = `SharinPix-Import Command...`

ImportCommand.flags = {
  file: flags.string({ char: 'f', description: `file to read` }),
}

module.exports = ImportCommand
