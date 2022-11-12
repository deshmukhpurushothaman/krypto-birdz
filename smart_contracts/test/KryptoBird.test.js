const { assert } = require('chai');

const KryptoBird = artifacts.require('./KryptoBird');

require('chai').use(require('chai-as-promised')).should();

contract('KryptoBird', async (accounts) => {
  let contract;
  before(async () => {
    contract = await KryptoBird.deployed();
  });

  describe('deployment', async () => {
    // Deployment test
    it('deployment successful', async () => {
      //   contract = await KryptoBird.deployed();
      const address = contract.address;
      assert.notEqual(address, '');
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    // Minting name and symbol test
    it('name test', async () => {
      const name = await contract.name();
      assert.equal(name, 'KryptoBird');
    });

    it('symbol test', async () => {
      const symbol = await contract.symbol();
      assert.equal(symbol, 'KBZ');
    });
  });

  describe('Minting', async () => {
    it('create new token', async () => {
      const res = await contract.mint('token1');
      const totalSupply = await contract.totalSupply();

      // Success
      assert.equal(totalSupply, 1);
      const event = res.logs[0].args; // Logs are coming from tranfer event
      assert.equal(
        event._from,
        '0x0000000000000000000000000000000000000000',
        'from is the contract'
      );
      assert.equal(event._to, accounts[0], 'to is msg.sender');

      // Failure
      await contract.mint('token1').should.be.rejected;
    });
  });

  describe('indexing', async () => {
    it('lists kryptobird', async () => {
      await contract.mint('token2');
      await contract.mint('token3');
      await contract.mint('token4');
      const totalSupply = await contract.totalSupply();

      let result = [];
      let KryptoBird;
      for (i = 1; i <= totalSupply; i++) {
        KryptoBird = await contract.kryptoBirdz(i - 1);
        result.push(KryptoBird);
      }

      // assertions
      let expected = ['token1', 'token2', 'token3', 'token4'];
      assert.equal(result.join(','), expected.join(','));
    });
  });
});
