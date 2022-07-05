//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    'delegatecall' is a low level function similar to 'call'
    When contract A executes delegatecall to contract B, contract B's code is executed with 
    contract A's storage, msg.sender & msg.value.
*/
contract B {
    // NB: Deploy this contract first
    // NB: Storage layout must be the same as contract A
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _contract, uint256 _num) public payable {
        // A's storage is set, B is not modified
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}
