const {expect, test} = require('@oclif/test'),
      sinon = require('sinon'),
      sharinpix = require('sharinpix-js')

describe('import', () => {
  var fakepost;
  beforeEach(() => {
    instance = sharinpix.get_instance()
    fakepost = sinon.fake.returns(new Promise((resolve, reject) => {
      return('apple pie')        
    }))

    returnValue = {
      post: fakepost
    }

    var stub = sinon.stub(sharinpix, 'get_instance')
    stub.returns(returnValue)
  })

  test
  .stdout()
  .command(['import','--file','sample.csv'])
  .it('sends csv file successfully', () => {
    expect(fakepost.getCall(0).args[0]).to.equals('/imports')
    expect(fakepost.getCall(0).args[1].album_id).to.equals('000000000000000000')
    expect(fakepost.getCall(0).args[1].url).to.equals('http://lorempixel.com/400/200/sports/')
    expect(fakepost.getCall(0).args[1].tags).to.equals('foo,bar,dim')
    expect(fakepost.getCall(0).args[1].metadatas).to.equals('{"key":"value"}')
  })
})
