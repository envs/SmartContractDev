//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Token {
    // String type variables to idenify the token
    string public name = "My Hardhat Token";
    string public symbol = "MHT";

    // Fixed amount of tokens stored in an unsigned integer type variable
    uint256 public totalSupply = 1000000;

    // An address type variable is used to store ethereum accounts
    address public owner;

    // Here we store each account balance in relation to an address, through mapping
    mapping(address => uint256) balances;

    // Contract initialization through the constructor
    constructor() {
        // totalSupply is assigned to the transaction sender (the account deploying the contract)
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    // A function to transfer tokens
    // external modifier makes a function "only" callable from outside the contract
    function transfer(address to, uint256 amount) external {
        console.log("Sender balance is %s tokens", balances[msg.sender]);
        console.log("Trying to send %s tokens to %s\n", amount, to);
        // Check if transaction sender has enough tokens
        require(balances[msg.sender] >= amount, "Not enough tokens");
        // Transfer the amount
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    // A read-only function to retrieve token balance of a given account/address
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
