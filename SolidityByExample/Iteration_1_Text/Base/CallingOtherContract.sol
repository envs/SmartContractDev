//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// CALLING OTHER CONTRACT
/**
    Contract can call other contracts in 2 ways
        * The easiest way is to just call it like: A.foo(x,y,z)
        * Another way is to use the low-level "call" NB: This method is not recommended
*/
contract Callee {
    uint256 public x;
    uint256 public value;

    function setX(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint256 _x)
        public
        payable
        returns (uint256, uint256)
    {
        x = _x;
        value = msg.value;
        return (x, value);
    }
}

contract Caller {
    function setX(Callee _callee, uint256 _x) public {
        uint256 x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    function setXandSendEther(Callee _callee, uint256 _x) public payable {
        (uint256 x, uint256 value) = _callee.setXandSendEther{value: msg.value}(
            _x
        );
    }
}

// CONTRACT THAT CREATES OTHER CONTRACTS
/**
    Contracts can be created by other contracts using the "new" keyword.
    Since 0.8.0, "new" keyword supports "create2" feature by specifying "salt" options.
*/

contract Car {
    address public owner;
    string public model;
    address public carAddr;

    constructor(address _owner, string memory _model) payable {
        owner = _owner;
        model = _model;
        carAddr = address(this);
    }
}

contract CarFactory {
    Car[] public cars;

    function create(address _owner, string memory _model) public {
        Car car = new Car(_owner, _model);
        cars.push(car);
    }

    function createAndSendEther(address _owner, string memory _model)
        public
        payable
    {
        Car car = (new Car){value: msg.value}(_owner, _model);
        cars.push(car);
    }

    function create2(
        address _owner,
        string memory _model,
        bytes32 _salt
    ) public {
        Car car = (new Car){salt: _salt}(_owner, _model);
        cars.push(car);
    }

    function create2AndSendEther(
        address _owner,
        string memory _model,
        bytes32 _salt
    ) public payable {
        Car car = (new Car){value: msg.value, salt: _salt}(_owner, _model);
        cars.push(car);
    }

    function getCar(uint256 _index)
        public
        view
        returns (
            address owner,
            string memory model,
            address carAddr,
            uint256 balance
        )
    {
        Car car = cars[_index];
        return (car.owner(), car.model(), car.carAddr(), address(car).balance);
    }
}
