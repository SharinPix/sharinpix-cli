{expect, test} = require('@oclif/test')
sharinpix = require('sharinpix-js')
sinon = require('sinon')

describe 'sharinpix url', -> 
  process.env.SHARINPIX_URL='sharinpix://402ce4f5-0000-0000-0000-cb6ab93bebf2:2L6HuR0jSt-zDgZejXFajsSF7Rg-wY4cvIBuR7XaDHRE3HQ@api.sharinpix.com/api/v1'
  not_set_message = "SHARINPIX_URL is not set. Run the following commands: \nOn Windows: set SHARINPIX_URL=<<value>>\nOn Unix: export SHARINPIX_URL=<<value>>"
  is_set_message = 'SHARINPIX_URL is set. You can now interact with SharinPix.'
  cannot_connect_message = 'Cannot connect to Sharinpix'

  describe 'can retrieve org id', ->
    before ->
      fakeget = sinon.fake.returns new Promise (resolve, reject)->
        resolve({id: 'a554f3b3-ad2e-4689-b00a-1ee9b41dd4fb'})

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
        expect(ctx.stdout).of.contain(not_set_message)
      )

  describe 'cannot retrieve org id', ->
    before ->
      process.env.SHARINPIX_URL='sharinpix://402ce4f5-0000-0000-0000-cb6ab93bebf2:2L6HuR0jSt-zDgZejXFajsSF7Rg-wY4cvIBuR7XaDHRE3HQ@api.sharinpix.com/api/v1'

      fakeget = sinon.fake.returns new Promise (resolve, reject)->
        reject()
      
      sharinpix.get_instance.restore()
      stub = sinon.stub sharinpix, 'get_instance'
      stub.returns {get: fakeget}

    test
      .stderr()
      .command ['auth']
      .it('shows message when cannot connect to sharinpix', (ctx)->
        expect(ctx.stderr).of.contain(cannot_connect_message)
      )
