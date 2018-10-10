{Command, flags} = require('@oclif/command')
sharinpix = require('sharinpix-js')
async = require('async')
csv = require('fast-csv')
fs = require('fs')
queue = require('./queue')

class MoveCommand extends Command
  run: =>
    {flags} = @parse(MoveCommand)
    file = flags.file

    q = new queue({
      concurency: 5,
      callback: (task)->
        await sharinpix.get_instance().put("/albums/#{task.src}?merge=true",{
          album:
            public_id: task.dst
        })
    })

    await new Promise (resolve, reject)->
      csv
        .fromStream(fs.createReadStream(file))
        .on "data", (data)->
          q.push(src: data[0], dst: data[1])
        .on "end", ->
          resolve()
      
    await q.end()

MoveCommand.description = "Move sharinpix images from one album to another"

MoveCommand.flags = {
  file: flags.string(
    char: 'f'
    description: 'Path to csv file'
    required: true)
}

module.exports = MoveCommand
