{expect, test} = require '@oclif/test'
sinon = require 'sinon'
sharinpix = require 'sharinpix-js'

describe 'import', ->
  fakepost = sinon.fake

  beforeEach ()->
    fakepost = fakepost.returns new Promise (resolve, reject) -> 
      return 'fake response'

    stub = sinon.stub sharinpix, 'get_instance'
    stub.returns {post: fakepost}

  test
  .stdout()
  .command ['import','--file','importsample.csv']
  .it 'sends csv file successfully', ->
    expect(fakepost.getCall(0).args[0]).to.equals('/imports')
    expect(fakepost.getCall(0).args[1].album_id).to.equals('000000000000000000')
    expect(fakepost.getCall(0).args[1].url).to.equals('http://lorempixel.com/400/200/sports/')
    expect(fakepost.getCall(0).args[1].tags).to.equals('foo,bar,dim')
    expect(fakepost.getCall(0).args[1].metadatas).to.equals('{"key":"value"}')
