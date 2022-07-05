//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Enums are useful to model choice and keep track of state
// NB: Enums can be declared outside of a contract
contract Enum {
    // Enum representing shipping address
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    // Default value is the first element listed in the definition of the type, in
    // this case "Pending"

    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    // Update status by passing uint to input
    function set(Status _status) public {
        status = _status;
    }

    // You can update to a specific enum
    function cancel() public {
        status = Status.Canceled;
    }

    // Delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }
}
