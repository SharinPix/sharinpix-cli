{expect, test} = require('@oclif/test')
sinon = require('sinon')
sharinpix = require('sharinpix-js')

describe 'move', ->
  fakeput = null

  beforeEach ->
    fakeput = sinon.fake.returns new Promise (resolve, reject)->
      resolve()

    stub = sinon.stub sharinpix, 'get_instance'
    stub.returns {put: fakeput}

  test
  .stdout()
  .command ['move', '--file', 'movesample.csv']
  .it 'moves sharinpix images from one album to another', -> 
    expect(fakeput.getCall(0).args[0]).to.contains('100000000000000000')
    expect(fakeput.getCall(0).args[1].album.public_id).to.equals('300000000000000000')
    expect(fakeput.getCall(1).args[0]).to.contains('000000000000000000')
    expect(fakeput.getCall(1).args[1].album.public_id).to.equals('200000000000000000')
