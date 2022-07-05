//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/**
    Reading and Writing to a State Variable
 */

contract SimpleStorage {
    // State variable to store a number
    uint public num;

    // Send a transaction to write to a state variable
    function set(uint _num) public {
        num = _num;
    }

    // Read from a state variable without sending a transaction
    function get() public view returns (uint) {
        return num;
    }
}