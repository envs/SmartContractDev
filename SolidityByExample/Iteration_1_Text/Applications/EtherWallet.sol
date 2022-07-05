//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    SPECIFICATIONS:
    A Basic Wallet.
    Structure of the Contract:
        * Anyone can send ETH
        * Only the owner can withdraw
*/
contract EtherWallet {
    // State Variable
    address payable public owner;

    // Constructor
    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {} // Gives the ability to receive Ether

    // Functions
    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "Caller is not the owner");
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
