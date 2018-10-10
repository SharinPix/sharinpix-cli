{Command, flags} = require('@oclif/command')
Sharinpix = require('sharinpix-js')
async = require('async')
csv = require('fast-csv')
fs = require('fs')
Queue = require('./queue')

class ImportCommand extends Command
  run: =>
    {flags} = @parse(ImportCommand)
    file = flags.file

    q = new Queue({
      concurency: 5,
      callback: (task)->
        await Sharinpix.get_instance().post("/imports", {
          import_type: 'url'
          album_id: "#{task.album_id}"
          url: "#{task.url}"
          tags: "#{task.tags}"
          metadatas: "#{task.metadatas}"
        })
    })

    await new Promise (resolve, reject)->
      csv
        .fromStream(fs.createReadStream(file), delimiter: ';')
        .on "data", (data)->
          q.push(album_id: data[0], url: data[1], tags: data[2], metadatas: data[3])
        .on "end", ->
          console.log('read csv')
          resolve()

    await q.end()

ImportCommand.description = "Import images"

ImportCommand.flags = 
  file: flags.string(
    char: 'f'
    description: 'Path of file to import'
    required: true)

module.exports = ImportCommand
