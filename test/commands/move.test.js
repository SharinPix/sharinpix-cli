const {expect, test} = require('@oclif/test')

describe('move', () => {
  test
  .stdout()
  .command(['move', '--file', 'movesample.csv'])
  .it('runs hello --name jeff', ctx => {
    // expect(ctx.stdout).to.contain('hello jeff')
  })
})
