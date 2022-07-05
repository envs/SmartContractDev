//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract EtherUnits {
    uint public oneWei = 1 wei;
    bool public isOneWei = 1 wei == 1;  // true: 1 wei is equal to 1

    uint public oneEther = 1 ether;
    bool public isOneEther = 1 ether == 1e18;   // 1 ether is equal to 10^18 wei
}

contract Gas {
    /**
        How much ether do you need to pay for a transaction?
        You pay "gas_spent" * "gas_price" amount of ether, where
            * 'gas' is the unit of computation
            * 'gas spent' is the total amount of gas used in a transaction
            * 'gas price' is how much ether you are willing to pay per gas
        NB: Transactions with higher gas price have higher priority to be included in a block
            Unspent gas will be refunded
            Gas Limit:
                There are 2 upper bounds to the amount of gas you can spend
                    - "gas limit" is the max amount of gas you are willing to use for your trxn (set by you)
                    - "block gas limit" is the max amount of gas allowed in a block (set by the network)
    */
    uint public i = 0;
    
    function forever() public {
        // Using up all of the gas you sent causes your transaction to fail
        // State changes are undone; Gas spent are not refunded
        // In this function, let's implement a loop that runs until all gas are spent and transaction fails
        while(true) {
            i += 0;
        }
    }
    
}