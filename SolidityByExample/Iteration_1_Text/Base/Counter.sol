//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// A simple contract you can get, increment, and decrement the count store in this contract
contract Counter {
    uint256 public count;

    // Function to get the current count
    function get() public view returns (uint256) {
        return count;
    }

    // Function to increment count by 1
    function inc() external {
        count += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        count -= 1;
    }
}
