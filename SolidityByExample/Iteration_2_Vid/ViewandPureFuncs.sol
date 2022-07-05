//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    "view" can read data from the blockchain, whereas "pure" don't read anything from the blockchain.
    Hence, "view" functions doesn't modify any state variables or write anything to the blockchain. It just reads them
    Pure function is a read-only function and does not modify anything on the blockchain. It also doesn't 
    read any data from the blockchain, such as the state variable or any information about the blockchain
*/

contract ViewandPureFuncs {
    uint256 public num;

    function viewFunc() external view returns (uint256) {
        return num;
    }

    function pureFunc() external pure returns (uint256) {
        return 1;
    }

    function addToNum(uint256 x) external view returns (uint256) {
        return num * x;
    }

    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
