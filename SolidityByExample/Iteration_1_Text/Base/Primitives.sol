//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Primitives {
    // We will look at boolean, uint, int, & address

    bool public boo = true;

    /**
        uint - unsigned integer, meaning non-negative integers
        uint8 ranges from 0 to 2^8 - 1
        uint16 ranges from 0 to 2^16 - 1
        ...
        uint256 ranges from 0 to 2^256 - 1
     */
    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123; // NB: uint is an alias for uint256

    /**
        Negative numbers are allowed for int types.
        int256 ranges from -2^255 to 2^255 - 1
        int128 ranges from -2^127 to 2^127 - 1
     */
    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123;

    // minimum and maximum of int
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    /**
        In Solidity, the datatype 'bytes' represent a sequence of bytes.
        Solidity presents two type of byte types
            * fixed-size byte arrays
            * dynamically-sized byte arrays
        NB: The term bytes in Solidity represents a dynamic array of bytes. It's shorthand for byte[]
      */
    bytes1 a = 0xb5; // [10110101]
    bytes1 b = 0x56; // [01010110]

    // Default values -> Unassigned variables have a default value
    bool public defaultBoo; // false
    uint256 public defaultUint; // 0
    int256 public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}
