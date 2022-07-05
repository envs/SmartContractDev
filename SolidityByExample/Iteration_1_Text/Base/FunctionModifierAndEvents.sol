//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    Modifiers are code that can be run before and/or after a function call.
    Modifiers can be used to:
        * Restrict access
        * Validate inputs
        * Guard against re-entrancy hack
*/
contract FunctionModifier {
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        // Set the transaction sender as the owner of the contract
        owner = msg.sender;
    }

    // Modifier to check that the caller is the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
        // Underscore is a special character only used inside a function modifier
        // and it tells Solidity to execute the rest of the code.
    }

    // Modifiers can take inputs. The modifier below checks that the address passed
    // is not the zero address
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not a valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    // Modifiers can be called before and/or after a function. This prevents a function
    // from being called while it's still executing.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 _i) public noReentrancy {
        x -= _i;
        if (_i > 1) {
            decrement(_i - 1);
        }
    }
}

contract Event {
    /**
    Events allow logging to the Ethereum blockchain. Some use cases for events are:
        * Listening for events and updating User Interface
        * A cheap form of storage
    */
    // In Event declaration, up to 3 parameters can be indexed
    // Indexed parameters help you filter the logs by the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World");
        emit Log(msg.sender, "Hello EVM");
        emit AnotherLog();
    }
}
