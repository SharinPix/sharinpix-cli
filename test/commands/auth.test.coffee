{expect, test} = require('@oclif/test')
sharinpix = require('sharinpix-js')
sinon = require('sinon')

describe 'sharinpix url', -> 
  
  process.env.SHARINPIX_URL='sharinpix://402ce4f5-0000-0000-0000-cb6ab93bebf2:2L6HuR0jSt-zDgZejXFajsSF7Rg-wY4cvIBuR7XaDHRE3HQ@api.sharinpix.com/api/v1'
  not_set_message = "SHARINPIX_URL is not set. Run the following commands: \nOn Windows: set SHARINPIX_URL=<<value>>\nOn Unix: export SHARINPIX_URL=<<value>>"
  is_set_message = 'SHARINPIX_URL is set. You can now interact with SharinPix.'
  cannot_connect_message = 'Cannot connect to Sharinpix'

  before ->
    fakeget = sinon.fake.returns new Promise (resolve, reject)->
      resolve(is_set_message)

    stub = sinon.stub sharinpix, 'get_instance'
    stub.returns {get: fakeget}

  afterEach ->
    delete process.env.SHARINPIX_URL

  test
    .stdout()
    .command ['auth']
    .it('shows message when sharinpix url is set', (ctx)->
      expect(ctx.stdout).to.contain(is_set_message)
    )

  test
    .stdout()
    .command ['auth']
    .it('shows message when sharinpix url is not set', (ctx)->
      expect(ctx.stdout).to.contain(not_set_message)
    )

  # before ->
  #   fakeget = sinon.fake.returns new Promise (resolve, reject)->
  #     reject()

  #   stub = sinon.stub sharinpix, 'get_instance'
  #   stub.returns {get: fakeget}

  # test
  #   .stderr()
  #   .command ['auth']
  #   .it('shows message when cannot connect to Sharinpix', (ctx)->
  #     expect(ctx.stderr).to.deep.equal('Cannot connect to Sharinpix')
  #   )
