//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    From 0.8, these features are activated by default:
        * safe math
        * custom error
        * function declaration outside of a contract
        * renaming import function/contract
            - e.g. import helper as hp
        * create2 - before 0.8, you use the assembly {...} syntax
*/

contract SafeMath {
    function testUnderflow() public pure returns (uint256) {
        // Should throw an error
        uint256 x = 0;
        x--;
        return x;
    }

    function testUncheckedUnderflow() public pure returns (uint256) {
        uint256 x = 0;
        unchecked {
            x--;
        }
        return x;
    }
}

// custom error (NB: It's declared outside of the contract, so other contracts can use it)
error Unauthorized();

contract VendingMachine {
    address payable owner = payable(msg.sender);

    function withdraw() public {
        if (msg.sender != owner) revert Unauthorized();
        owner.transfer(address(this).balance);
    }
}

// Function outside  of a contract (NB: For ease of use by other contracts too).
function helper(uint256 x) pure returns (uint256) {
    return x * 2;
}

contract TestHelper {
    function test(uint256 _x) external pure returns (uint256) {
        return helper(_x);
    }
}

// Salted contract creations / create2
contract D {
    uint256 public x;

    constructor(uint256 a) {
        x = a;
    }
}

contract Create2 {
    function getBytes32(uint256 salt) external pure returns (bytes32) {
        return bytes32(salt);
    }

    function getAddress(bytes32 salt, uint256 arg)
        external
        view
        returns (address)
    {
        address addr = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff),
                            address(this),
                            salt,
                            keccak256(
                                abi.encodePacked(type(D).creationCode, arg)
                            )
                        )
                    )
                )
            )
        );
        return addr;
    }

    address public deployedAddr;

    function createDSalted(bytes32 salt, uint256 arg) public {
        D d = new D{salt: salt}(arg);
        deployedAddr = address(d);
    }
}
