{Command, flags} = require('@oclif/command')
Sharinpix = require('sharinpix-js')
async = require('async')
csv = require('csvtojson')
fs = require('fs')
queue = require('./queue')
ndjson = require('ndjson')

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
        console.log '>', obj
        await Sharinpix.get_instance().post(
          '/imports',
          obj
        ).then (result)->
          fs.writeSync(success,JSON.stringify(input)+"\n")
        , (err)->
          fs.writeSync(errors, JSON.stringify(input)+"\n")

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
