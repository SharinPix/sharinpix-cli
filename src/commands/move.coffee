{Command, flags} = require('@oclif/command')
sharinpix = require('sharinpix-js')
async = require('async')
csv = require('fast-csv')
fs = require('fs')

class MoveCommand extends Command
  run: =>
    {flags} = @parse(MoveCommand)
    file = flags.file

    q = async.queue((task, callback)=>
      line = "#{task.src}, #{task.dst}"
      sharinpix.get_instance().put("/albums/#{task.src}?merge=true",
        {
          album:
            public_id: task.dst
        }
      ).then((res)->
        console.log line
        callback()
      , (err)->
        console.error line
        callback()
      )
    , 10)

    await new Promise (resolve, reject)->
      csv
        .fromStream(fs.createReadStream(file))
        .on "data", (data)->
          q.push(src: data[0], dst: data[1])
        .on "end", ->
          resolve()

MoveCommand.description = "Move sharinpix images from one album to another"

MoveCommand.flags = {
  file: flags.string(
    char: 'f'
    description: 'Path to csv file'
    required: true)
}

module.exports = MoveCommand
