{Command, flags} = require('@oclif/command')
Sharinpix = require('sharinpix-js')
async = require('async')
csv = require('fast-csv')
fs = require('fs')

class ImportCommand extends Command
  run: ->
    {flags} = @parse(ImportCommand)
    file = flags.file

    q = async.queue((task, callback)->
      console.log 'task'
      line = "#{task.album_id},#{task.url},#{task.tags},#{task.metadatas}"
      Sharinpix.get_instance().post("/imports", {
        import_type: 'url'
        album_id: "#{task.album_id}"
        url: "#{task.url}"
        metadatas: "#{task.metadatas}"
      }).then((result)->
        console.log(line)
        callback()
      , (err)->
        console.error(line)
        callback()
      )
    , 10)

    await new Promise (resolve, reject)->
      console.log(1)
      csv
        .fromStream(fs.createReadStream(file), delimiter: ';')
        .on "data", (data)->
          console.log 'read'
          q.push(album_id: data[0], url: data[1], tags: data[2], metadatas: data[3])
        .on "end", ->
          resolve()

    await new Promise (resolve, reject)->
      q.drain ()->
        resolve()

ImportCommand.description = "Import images"

ImportCommand.flags = 
  file: flags.string(
    char: 'f'
    description: 'Path of file to import'
    required: true)

module.exports = ImportCommand
