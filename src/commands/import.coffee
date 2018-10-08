{Command, flags} = require('@oclif/command')
Sharinpix = require('sharinpix-js')
async = require('async')
csv = require('fast-csv')
fs = require('fs')

wstream = fs.createWriteStream('myOutput.txt')

class ImportCommand extends Command
  run: =>
    {flags} = @parse(ImportCommand)
    file = flags.file

    q = async.queue((task, callback)=>
      line = "#{task.album_id},#{task.url},#{task.tags},#{task.metadatas}"
      Sharinpix.get_instance().post("/imports", {
        import_type: 'url'
        album_id: "#{task.album_id}"
        url: "#{task.url}"
        tags: "#{task.tags}"
        metadatas: "#{task.metadatas}"
      })
      .then((result)->
        console.log(line)
        callback()
      , (err)->
        console.error(line)
        callback()
      )
    , 10)

    await new Promise (resolve, reject)->
      try
        csv
          .fromStream(fs.createReadStream(file), delimiter: ';')
          .on "data", (data)->
            q.push(album_id: data[0], url: data[1], tags: data[2], metadatas: data[3])
          .on "end", ->
            resolve()
      catch e
        @log e
        console.log e

    q.drain =>
      resolve()

ImportCommand.description = "Import images"

ImportCommand.flags = 
  file: flags.string(
    char: 'f'
    description: 'Path of file to import'
    required: true)

module.exports = ImportCommand
