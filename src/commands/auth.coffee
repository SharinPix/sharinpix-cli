{Command, flags} = require('@oclif/command')
sharinpix = require('sharinpix-js')
cli =  require('cli-ux')

class AuthCommand extends Command 
  run: =>
    not_set_message = "SHARINPIX_URL is not set. Run the following commands: \nOn Windows: set SHARINPIX_URL=<<value>>\nOn Unix: export SHARINPIX_URL=<<value>>"
    {flags} = @parse(AuthCommand)

    if(Object.keys(flags).length == 0) 
        if (process.env.SHARINPIX_URL)
          try
            sharinpix.get_instance().get("/organization")
            .then (result)=>
              @log result
              if (result.id)
                @log 'SHARINPIX_URL is set. You can now interact with SharinPix.'
            , (err)=>
              @log 'Cannot connect to Sharinpix'
          catch e
        else 
          @log not_set_message
    else if (flags.view)
      if (process.env.SHARINPIX_URL) 
        @log process.env.SHARINPIX_URL
      else
        @log not_set_message

AuthCommand.description = "It helps you define the value of the environment variable: SHARINPIX_URL
...
The SHARINPIX_URL environment variable is used by the CLI to identify which Salesforce Organization to interact with.
This value can be found in the 'Secrets' section of the SharinPix Administration Dashboard."

AuthCommand.flags = {
  view: flags.boolean(
    char: 'v'
    description: 'view the value of SHARINPIX_URL')
}

module.exports = AuthCommand
