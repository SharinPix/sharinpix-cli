const {expect, test} = require('@oclif/test'),
      fs = require('fs'),
      csv = require('fast-csv'),
      _ = require('lodash'),
      assert = require("assert")

describe('import', () => {
  test
  .stdout()
  .command(['import','--file','sample.csv'])
  .it('reads csv file', ctx => {
    assert.notEqual(-1, ctx.stdout.indexOf('Album Id length: 18'));
    expect(ctx.stdout).to.contain('Metadatas: {}')
  })

  test
  .stderr()
  .command(['import','--file','sample_bad.csv'])
  .it('AlbumId not 18 characters', ctx => {
    expect(ctx.stderr).to.contain('Album Id in sample_bad.csv should contain 18 characters!')
  })
})
