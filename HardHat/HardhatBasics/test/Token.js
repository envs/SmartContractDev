const { expect } = require("chai");

/**
    `describe` is a mocha function that allows you to organize your tests. NB: It's not actually needed, but 
    having your tests organized makes debugging them easier. All Mocha functions are available in global scope.
    `describe` receives the name of a section of your test suite, and a callback.
    The callback must define the  tests of that section. This callback can't be an async function.
    Mocha has 4 functions that let you hook into the test runner;;s lifecycle. There are:
        `before`, `beforeEach`, `after`, `afterEach`
    They are good in setting up the environment for tests, and cleaning it up after.
    A common pattern is to declare some variables, and assign them in the `before` and `beforeEach` callbacks.
*/

describe("Token contract", () => {

    let Token, hardhatToken, owner, addr1, addr2, addrs;
    // beforeEach runs before each test, re-deploying the contract every time.
    beforeEach(async () => {
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        Token = await ethers.getContractFactory("Token");
        // To deploy our contract, we just need to call Token.deploy(), and await for it to be deployed(), which happens once the transaction has been mined
        hardhatToken = await Token.deploy()
        /**
         * // A signer in ether.js is an object that represents an Ethereum account.
            // It's used to send transactions to contracts and other accounts.
            // Here, we are getting a list of the accounts in the node (Hardhat network) we are connected to, and only keeping the first one.
            const [owner] = await ethers.getSigners();  // ethers is a global variable

            // A ContractFactory in ether.js is an abstraction used to deploy new smart contrcts.
            // Hence, Token here is a factory in this instance.
            const Token = await ethers.getContractFactory("Token");

            // Calling deploy() on a ContractFactory will start deployment, and return a Promise that resolves to a Contract.
            // NB: This is the object that HAS A METHOD FOR EACH of your smart contract functions.
            const hardhatToken = await Token.deploy();
         */
    });

    describe("Deployment", () => {
        // `it` is another Mocha function used to define your test. It receives the test name, and a callback function
        // This test expects the owner variable stored in the contract to be equal to Signer's owner
        it("Should set the right owner", async () => {
            expect(await hardhatToken.owner()).to.equal(owner.address);
        });
        it("Should assign the total supply of tokens to the owner", async () => {
            const ownerBalance = await hardhatToken.balanceOf(owner.address);
            expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
        });
    });

    describe("Transactions", async () => {
        it("Should transfer tokens between accounts", async () => {
            // Transfer 100 tokens from owner to addr1
            await hardhatToken.transfer(addr1.address, 50);
            const addr1Balance = await hardhatToken.balanceOf(addr1.address);
            expect(addr1Balance).to.equal(50);

            // Transfer 50 tokens from addr1 to addr2
            await hardhatToken.connect(addr1).transfer(addr2.address, 50);
            const addr2Balance = await hardhatToken.balanceOf(addr2.address);
            expect(addr2Balance).to.equal(50);
        });

        it("Should fail if sender doesn't have enough tokens", async () => {
            const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);

            // Try and send 1 token from addr1 (has 0 token) to owner.
            await expect(hardhatToken.connect(addr1).transfer(owner.address, 1))
                .to
                .be
                .revertedWith("Not enough tokens");

            // Owner balance shouldn't have changed since there was no transfer
            expect(await hardhatToken.balanceOf(owner.address)).to.equal(initialOwnerBalance);
        });

        it("Should update balances after transfers", async () => {
            const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);

            // Transfer 100 tokens from owner to addr1
            await hardhatToken.transfer(addr1.address, 100);
            // Transfer another 50 tokens from owner to addr2
            await hardhatToken.transfer(addr2.address, 50);

            // Check balances
            const finalOwnerBalance = await hardhatToken.balanceOf(owner.address);
            expect(finalOwnerBalance).to.equal(initialOwnerBalance.sub(150));

            const addr1Balance = await hardhatToken.balanceOf(addr1.address);
            expect(addr1Balance).to.equal(100);

            const addr2Balance = await hardhatToken.balanceOf(addr2.address);
            expect(addr2Balance).to.equal(50);
        });
    });
});