const {Command, flags} = require('@oclif/command')
const cli =  require('cli-ux')

class AuthCommand extends Command {
  async run() {
    const not_set_message = "SHARINPIX_URL is not set. Run the following commands: \nOn Windows: set SHARINPIX_URL=<<value>>\nOn Unix: export SHARINPIX_URL=<<value>>"
    const {flags} = this.parse(AuthCommand)
    if(Object.keys(flags).length === 0) {
        if(process.env.SHARINPIX_URL) {
          this.log('SHARINPIX_URL is set. You can now interact with SharinPix.')
        }
        else {
          this.log(not_set_message)
        }
    }
    else if(flags.view){
      if(process.env.SHARINPIX_URL) {
        this.log(process.env.SHARINPIX_URL)
      }
      else {
        this.log(not_set_message)
      }
    }
  }
}

AuthCommand.description = `It helps you define the value of the environment variable: SHARINPIX_URL
...
The SHARINPIX_URL environment variable is used by the CLI to identify which Salesforce Organization to interact with.
This value can be found in the "Secrets" section of the SharinPix Administration Dashboard.
`

AuthCommand.flags = {
  view: flags.boolean({char: 'v', description: 'view the value of SHARINPIX_URL'}),
}

module.exports = AuthCommand
