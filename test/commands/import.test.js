const {expect, test} = require('@oclif/test')

describe('import', () => {
  test
  .stdout()
  .command(['import'])
  .it('runs hello', ctx => {
    expect(ctx.stdout).to.contain('test must fail')
  })

  test
  .stdout()
  .command(['import', '--name', 'jeff'])
  .it('runs hello --name jeff', ctx => {
    expect(ctx.stdout).to.contain('hello jeff')
  })

  test
  .stdout()
  .command(['import', '--file', '/sample.csv'])
  .it('reads csv file', ctx => {
    expect(ctx.stdout).to.contain('http')
  })
})
