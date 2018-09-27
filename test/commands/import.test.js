const {expect, test} = require('@oclif/test')

describe('import', () => {
  test
  .stdout()
  .command(['import','--file','sample.csv'])
  .it('reads csv file', ctx => {
    expect(ctx.stdout).to.contain('http')
  })
})
