{expect, test} = require '@oclif/test'
sinon = require 'sinon'
sharinpix = require 'sharinpix-js'
fs = require 'fs'

describe 'import', ->
  fakepost = null

  before ->
    fakepost = sinon.fake.returns new Promise (resolve, reject)->
      resolve()
    
    stub = sinon.stub sharinpix, 'get_instance'
    stub.returns {post: fakepost}

  test
  .stdout()
  .command ['import','--file','importsample.csv']
  .it 'sends csv file successfully', ->
    expect(fakepost.getCall(0).args[0]).to.equals('/imports')

    expect(fakepost.getCall(0).args[1].album_id).to.equals('000000000000000000')
    expect(fakepost.getCall(0).args[1].url).to.equals('http://lorempixel.com/400/200/sports/')
    expect(fakepost.getCall(0).args[1].tags).to.deep.equal(["sport", "action", "fun"])
    expect(fakepost.getCall(0).args[1].metadatas).to.deep.equal({"key":"value"})
    
    expect(fakepost.getCall(1).args[1].album_id).to.equals('100000000000000000')
    expect(fakepost.getCall(1).args[1].url).to.equals('http://lorempixel.com/400/200/portrait/')
    expect(fakepost.getCall(1).args[1].tags).to.deep.equal(["portrait", "face", "amazing"])
    expect(fakepost.getCall(1).args[1].metadatas).to.deep.equal({"key":"value"})

    expect(fakepost.getCall(2).args[1].album_id).to.equals('200000000000000000')
    expect(fakepost.getCall(2).args[1].url).to.equals('http://lorempixel.com/400/200/forest/')
    expect(fakepost.getCall(2).args[1].tags).to.deep.equal(["forest", "tree", "green"])
    expect(fakepost.getCall(2).args[1].metadatas).to.deep.equal({"key":"value"})

    expect(fakepost.getCall(3).args[1].album_id).to.equals('300000000000000000')
    expect(fakepost.getCall(3).args[1].url).to.equals('http://lorempixel.com/400/200/school/')
    expect(fakepost.getCall(3).args[1].tags).to.deep.equal(["student", "teacher", "school"])
    expect(fakepost.getCall(3).args[1].metadatas).to.deep.equal({"key":"value"})
    
    expect(fakepost.callCount).to.equals(4)

    expect(fs.existsSync('Success.csv')).to.be.true
