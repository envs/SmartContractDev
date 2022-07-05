//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    There are 3 types of variables in Solidity:
        * Local:
            - declared inside a function
            - not stored on the blockchain
        * State:
            - declared outside a function
            - stored on the blockchain
        * Global 
            - provides information about the blockchain
            - E.g.
                > block.(blockhash, coinbase, difficulty, gaslimit, number, timestamp)
                > msg.(data, gas, sender, sig, value) NB: .gas is deprecated in 0.4.21

    Constants are variables that cannot be modified.
    Their value is hard coded, and using constants can save gas cost.
*/
contract Variables {
    // State variables
    string public text = "hello";
    uint256 public num = 123;

    function doSomething() public view {
        // Loca variable
        uint256 i = 456;

        // Here are some global variables
        uint256 timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address the caller
    }
}

contract Constants {
    // Coding convention to uppercase constant variables
    // Gas cost for processing a constant is lower than other variables
    address public constant MY_ADDRESS =
        0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_UINT = 123;
}
