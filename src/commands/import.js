const {Command, flags} = require('@oclif/command')

class ImportCommand extends Command {
  async run() {
    const {flags} = this.parse(ImportCommand)
    const name = flags.name || 'world'
    this.log(`hello ${name} from /home/dipshika/sharinpix-cli/src/commands/import.js`)
  }
}

ImportCommand.description = `Describe the command here
...
Extra documentation goes here
`

ImportCommand.flags = {
  name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = ImportCommand
