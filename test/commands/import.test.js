const {expect, test} = require('@oclif/test'),
      sinon = require('sinon'),
      sharinpix = require('sharinpix-js')

describe('import', () => {
  var fakepost;
  beforeEach(() => {
    fakepost = sinon.fake()
    var stub = sinon.stub(sharinpix, 'get_instance')
    stub.returns({post: fakepost})
  })

  test
  .stdout()
  .command(['import','--file','sample.csv'])
  .it('sends csv file successfully', ctx => {
    // expect(fakepost.getCall(0).args).to.equals([])
    expect(fakepost.getCall(0).args[0]).to.equals('/imports')
    expect(fakepost.getCall(0).args[1].album_id).to.equals('000000000000000000')
    expect(fakepost.getCall(0).args[1].url).to.equals('http://lorempixel.com/400/200/sports/')
    // expect(fakepost.getCall(0).args[1].tags).to.equals([])
    //expect(fakepost.getCall(0).args[1].metadatas.import_id).to.equals('{"key":"value"}')
  })
})
