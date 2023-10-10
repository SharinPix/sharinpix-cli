import {expect, test} from '@oclif/test'

describe('import:file', () => {
  test
  .env({ SHARINPIX_SECRET_URL: undefined })
  .stdout()
  .command(['import file', '--path', 'test/import.csv']).catch(error => { expect(error.message).eql('SHARINPIX_SECRET_URL has not been set.') })
  .it('does not have the SHARINPIX_SECRET_URL')

  // test
  // .stdout()
  // .command(['import:file', '--name', 'jeff'])
  // .it('runs hello --name jeff', ctx => {
  //   expect(ctx.stdout).to.contain('hello jeff')
  // })
})
