{expect, test} = require '@oclif/test'
sinon = require 'sinon'
sharinpix = require 'sharinpix-js'

describe 'import', ->
  fakepost = null

  beforeEach ()->
    fakepost = sinon.fake.returns(new Promise((resolve, reject)->
      resolve()
    ))
    stub = sinon.stub sharinpix, 'get_instance'
    stub.returns {post: fakepost}

  test
  .stdout()
  .command ['import','--file','importsample.csv']
  .it 'sends csv file successfully', ->
    expect(fakepost.getCall(0).args[0]).to.equals('/imports')
    expect(fakepost.getCall(0).args[1].album_id).to.equals('000000000000000000')
    expect(fakepost.getCall(0).args[1].url).to.equals('http://lorempixel.com/400/200/sports/')
    expect(fakepost.getCall(0).args[1].tags).to.equals(['sport', 'action', 'fun'])
    expect(fakepost.getCall(0).args[1].metadatas).to.equals({"key":"value"})
    
    expect(fakepost.getCall(1).args[0]).to.equals('/imports')
    expect(fakepost.getCall(1).args[1].album_id).to.equals('000000000000000001')
    expect(fakepost.getCall(1).args[1].url).to.equals('http://lorempixel.com/400/200/portrait/')
    expect(fakepost.getCall(1).args[1].tags).to.equals(['portrait', 'face', 'amazing'])
    expect(fakepost.getCall(1).args[1].metadatas).to.equals({"key":"value"})
    
    expect(fakepost.callCount).to.equals(4)
