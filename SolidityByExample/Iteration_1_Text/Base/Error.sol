//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
    An error will undo all changes made to the state during a transaction
    You can throw an error by calling "require", "revert", or "assert".
        * require: is used to validate inputs and conditions before an execution
        * revert: is similar to 'require'
        * assert: is used to check for code that should never be false. 
        Failing an assertion probably means that there's a bug.
    Also, from v0.8.x, you can use custom error to save gas.
*/
contract Error {
    function testRequire(uint256 _i) public pure {
        // Require should validate conditions such as inputs, conditions before execution, return values from calls to other function
        require(_i < 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        // Revert is useful when the condition to check is complex.
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        // Assert should only be used to test for internal errors, and to check invariants.
        assert(num == 0);
    }

    // Custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}

contract Account {
    uint256 public balance;
    uint256 public constant MAX_UINT = 2**256 - 1;

    function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;

        // balance + _amount does not overflow if balance + _amount >= balance
        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;

        // balance - _amount does not underflow if balance >= _amount
        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }
        balance -= _amount;

        assert(balance <= oldBalance);
    }
}
