const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HelloWorld Testing", function () {

    it("Should deploy Hello World Contract", async function () {

        const helloWorldContractFactory = await ethers.getContractFactory("HelloWorld");
        const helloWorldContract = await helloWorldContractFactory.deploy();
        await helloWorldContract.deployed();

        // Now interact with attributes/methods of the contract
        const text = await helloWorldContract.getText();
        expect(text).to.equal("Hello World");
    });

    it("Should change text", async function () {

        const helloWorldContractFactory = await ethers.getContractFactory("HelloWorld");
        const helloWorldContract = await helloWorldContractFactory.deploy();
        await helloWorldContract.deployed();

        // Now interact with attributes/methods of the contract
        const newText = await helloWorldContract.setText("Hasta Luego");
        const text = await helloWorldContract.getText()
        expect(text).to.equal("Hasta Luego");
    });
});
