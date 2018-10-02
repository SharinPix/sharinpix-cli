const {expect, test} = require('@oclif/test')

describe('import', () => {
  test
  .stdout()
  .command(['import','--file','sample.csv'])
  .it('sends csv file successfully', ctx => {
    expect(ctx.stdout).to.contain('sample.csv imported')
  })
})
