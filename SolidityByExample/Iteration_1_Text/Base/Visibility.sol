//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    Functions and state variables have to declare whether they are accessible by other contracts.
    Functions can be declared as:
        * public: any contract and account can call
        * private: only inside contract that defines the function
        * internal: only inside contract that inherits an internal function
        * external: only other contracts and accounts can call

    State variables can be declared as public, private, or internal. You can't declare them as external.
 */

contract Base {
    // Private function can only be called "inside this contract"
    // NB: Contract that inherit this contract cannot call this function
    function privateFunc() private pure returns (string memory) {
        return "Private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    // Internal function can be called "inside this contract", "inside contract that inherit this contract"
    function internalFunc() internal pure returns (string memory) {
        return "Internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    // Public function can be called "inside this contract", "inside contract that inherit this contract", "by other contracts and accounts"
    function publicFunc() public pure returns (string memory) {
        return "Public function called";
    }

    // External functions can only be called "by other contacts and accounts"
    function externalFunc() external pure returns (string memory) {
        return "External function called";
    }

    // This functino will not compile since we are trying to call an external function here
    // function testExternalFunc() public pure returns (string memory) {
    //     return externalFunc();
    // }

    // State Variables
    string private privateVar = "My private variable";
    string internal internalVar = "My internal variable";
    string public publicVar = "My public variable";
}

contract Child is Base {
    // Inherited contracts do not have access to private functions and state variables
    // Internal function can be called inside child contracts
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}
