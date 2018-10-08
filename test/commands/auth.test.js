const {expect, test} = require('@oclif/test')

describe('sharinpix url', () => {
  afterEach(() => {
    delete process.env.SHARINPIX_URL;
  });

  process.env.SHARINPIX_URL='sharinpix://402ce4f5-0000-0000-0000-cb6ab93bebf2:2L6HuR0jSt-zDgZejXFajsSF7Rg-wY4cvIBuR7XaDHRE3HQ@api.sharinpix.com/api/v1'
  const not_set_message = "SHARINPIX_URL is not set. Run the following commands: \nOn Windows: set SHARINPIX_URL=<<value>>\nOn Unix: export SHARINPIX_URL=<<value>>"
  const is_set_message = 'SHARINPIX_URL is set. You can now interact with SharinPix.'

  test
    .stdout()
    .command(['auth'])
    .it('shows message when sharinpix url is set', ctx => {
      expect(ctx.stdout).to.contain(is_set_message)
    })

  test
    .stdout()
    .command(['auth'])
    .it('shows message when sharinpix url is not set', ctx => {
      expect(ctx.stdout).of.contain(not_set_message)
    })
});