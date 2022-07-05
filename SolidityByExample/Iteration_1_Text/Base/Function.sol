//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// NB: Public functions cannot accept certain data types as inputs or outputs
contract Function {
    // Functions can return multiple values
    function returnMany()
        public
        pure
        returns (
            uint256,
            bool,
            uint256
        )
    {
        return (1, true, 2);
    }

    // Return values can be named
    function named()
        public
        pure
        returns (
            uint256 x,
            bool b,
            uint256 y
        )
    {
        return (1, true, 2);
    }

    // Return values can be assigned to their name. Here,  return statement can be omitted
    function assigned()
        public
        pure
        returns (
            uint256 x,
            bool b,
            uint256 y
        )
    {
        x = 1;
        b = true;
        y = 2;
    }

    // Use destructuring assignment when calling another function that returns multiple values
    function destructingAssignments()
        public
        pure
        returns (
            uint256,
            bool,
            uint256,
            uint256,
            uint256
        )
    {
        (uint256 i, bool b, uint256 j) = returnMany();
        // Values can be left out
        (uint256 x, , uint256 y) = (4, 5, 6);
        return (i, b, j, x, y);
    }

    // Cannot use map for either input or output
    // Can use array for input
    function arrayInput(uint256[] memory _arr) public {}

    // can use array for output
    uint256[] public arr;

    function arrayOutput() public view returns (uint256[] memory) {
        return arr;
    }
}

/**
    Function Selector:
    When a function is called, the first 4 bytes of calldata specifies which function to call.
    This 4 bytes is called a FUNCTION SELECTOR.
    For example, the code below uses 'call' to execute 'transfer' on a contract at the address 'addr'
        addr.call(abi.encodeWithSignature("transfer(address, uint256)", 0xSomeAddress, 123))
    The first 4 bytes returned from abi.encodeWithSignature(...) is the FUNCTION SELECTOR.

    NB: Perhaps you can save a tiny amount of gas if you precompute and inline the function selector in your code.
*/

contract FunctionSelector {
    /**
        "transfer(address, uint256)"
        0xa9059cbb
        "transferFrom(address, address, uint256)"
        0x23b872dd
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}
