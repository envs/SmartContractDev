//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HelloWorld {
    string private text;
    address public owner;

    constructor() {
        text = "Hello World";
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function getText() public view returns (string memory) {
        return text;
    }

    function setText(string calldata _newText) public onlyOwner {
        text = _newText;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}
