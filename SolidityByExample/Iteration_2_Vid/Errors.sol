//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    When calling a function in a Smart Contract, there are 3 ways to throw an error:
        * require
        * revert
        * assert
    When errors are thrown in a transaction, your gas is refunded, state updates are reverted
 */
contract Error {
    function testRequire(uint256 _i) public pure {
        require(_i <= 10, "i > 10");
        // other codes goes here
    }

    function testRevert(uint256 _i) public pure {
        if (_i > 10) {
            revert("i > 10");
        }
    }

    uint256 public num = 123;

    function testAssert() public view {
        assert(num == 123);
    }
}
