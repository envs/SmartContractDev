//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    Contracts can inherit other contracts by using the "is" keyword.
    Function that is going to be overridden by a child contract must be declared as "virtual".
    Function that is going to override a parent function must use the keyword "override".
    Order of inheritance is important - You have to list the parent contracts in the order from "most base-like" to "most derived".
    
    Visual graph of inheritance coded below:
      A
     / \
    B   C
   / \ /
  F  D,E
 */

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// Contracts can inherit from multiple parent contracts.
// When a function is called that is defined multiple times in different contracts, parent contracts are searched from right
// to left, and in depth-first manner
contract D is B, C {
    // D.foo() returns "C" since C is the right most parent contract with function foo()
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() returns "B" since B is the right most parent contract with function foo()
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

// Inheritance must be ordered from "most base-like" to "most derived".
// Swapping the order of A and B will throw a compilation error.
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}

// SHADOWING INHERITED STATE VARIABLES
// Unlike functions, state variables CANNOT be overridden by re-declaring it in the child contract.
contract J {
    string public name = "Contract J";

    function getName() public view returns (string memory) {
        return name;
    }
}

// NB: Shadowing is disallowed in Solidity  0.6, hence the contract below will not compile.
// contract A is J {
//     string public name = "Contract B";
// }

contract K is J {
    // This is the correct way to override inherited state variables
    constructor() {
        name = "Contract K";
    }
    // K.getName() returns "Contract K"
}

/**
    CALLING PARENT CONTRACTS:
    Parent contracts can be called directly, or by using the keyword "super"
    By using "super", all of the immediate parent contracts will be called.
 */

/* Inheritance tree
      A
    /  \
    B   C
    \ /
     D
*/

contract W {
    event Log(string message);

    function foo() public virtual {
        emit Log("W.foo called");
    }

    function bar() public virtual {
        emit Log("W.bar called");
    }
}

contract X is W {
    function foo() public virtual override {
        emit Log("X.foo called");
        W.foo();
    }

    function bar() public virtual override {
        emit Log("X.bar called");
        super.bar();
    }
}

contract Y is W {
    function foo() public virtual override {
        emit Log("Y.foo called");
        W.foo();
    }

    function bar() public virtual override {
        emit Log("Y.bar called");
        super.bar();
    }
}

contract Z is X, Y {
    function foo() public override(X, Y) {
        super.foo();
    }

    function bar() public override(X, Y) {
        super.bar();
    }
}
