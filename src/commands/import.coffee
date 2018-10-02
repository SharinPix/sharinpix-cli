{Command, flags} = require('@oclif/command')
SpImport = require('sharinpix-import')
# Sharinpix = require('sharinpix');

class ImportCommand extends Command
  run: ->
    {flags} = @parse(ImportCommand)
    file = flags.file

    new Promise((resolve, reject) -> 
      resolve SpImport(file)
    ).then (result)=>
      @log("#{file} imported")

    # Sharinpix.get_instance().post("/imports", {
    #     import_type: 'url'
    #     album_id: 'dipshika'
    #     url: 'https://google.com'
    #     tags: []
    #     metadatas: {import_id: 'dipshika'}
    # }).then (results)=>
    #   this.log("blabla")

ImportCommand.description = "Import images"

ImportCommand.flags = file: flags.string(
  char: 'f'
  description: 'Path of file to import'
  required: true)

module.exports = ImportCommand