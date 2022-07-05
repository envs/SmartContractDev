//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Array {
    // Several ways to initialize an array
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    // Fixed sized array, all elements initialised to 0
    uint256[10] public myFixedSizeArr;

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }

    // Solidity can return the entire array, but this function should be avoided since arrays can grow indefinitely in length
    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    // Array methods

    function push(uint256 i) public {
        // Append to array.
        arr.push(i);
    }

    function pop() public {
        // Remove "last element" from array
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        // NB: Delete does not change the length of the array.
        // It resets the value at index to its default value
        delete arr[index];
    }

    function examples() external pure {
        // create array in memory, only fixed size can be created
        uint256[] memory a = new uint256[](5);
        a.length; // Not needed, just used to resolvie unused variable warning
    }
}

contract ArrayRemoveByShifting {
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []
    uint256[] public arr;

    function remove(uint256 _index) public {
        require(_index < arr.length, "Index out of bound");
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2); // [1,2,4,5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);

        arr = [1];
        remove(0); // []
        assert(arr.length == 0);
    }
}

contract ArrayReplaceFromEnd {
    uint256[] public arr;

    // Since deleting an element creates a gap in an array, once way to keep  the array
    // compact is to move the last element into the space to delete
    function remove(uint256 index) public {
        // Move last element into the place to delete & remove the last element
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];
        remove(1); // [1,4,3]
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2); // [1,4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}
