"use strict";
let id = 5;
let company = "Dinance";
let isPublished = true;
let x = "Hello";
let age;
age = 23;
let ids = [1, 2, 3, 4, 5];
let arr = [1, 2, 'hello', 'world'];
arr.push("Addition");
let person = [1, "hello", true];
let employee;
employee = [
    [1, "Shawn"],
    [2, 'Kelly'],
    [3, "Nicole"],
    [4, "Brandon"]
];
let pid; // A Union
pid = "Eben";
pid = "23";
var Direction;
(function (Direction) {
    Direction[Direction["Up"] = 0] = "Up";
    Direction[Direction["Down"] = 1] = "Down";
    Direction[Direction["Left"] = 2] = "Left";
    Direction[Direction["Right"] = 3] = "Right";
})(Direction || (Direction = {}));
const user = {
    id: 1,
    name: 'John'
};
// Type Assertion
let cusId = 1;
let customerId1 = cusId;
let customerId2 = cusId;
// Function
function addNum(x, y) {
    return x + y;
}
function log(message) {
    console.log(message);
}
// You can also write your function as in JS:
const getFullName = (name, surname) => {
    return name + " " + surname;
};
console.log(getFullName("Jeff", "Basel"));
const user2 = {
    id: 1,
    name: 'John'
};
const add = (x, y) => x + y;
const sub = (x, y) => x - y;
// Classes
class Person {
    constructor(_id, _name) {
        this.id = _id;
        this.name = _name;
    }
}
const brad = new Person(1, "brad");
class MyPerson {
    constructor(_id, _name) {
        this.id = _id;
        this.name = _name;
    }
    register() {
        return `${this.name} is now registered`;
    }
}
// Data Modifier or Access Modifier - private, protected, public (the default state)
// Extending class
class Employee extends MyPerson {
    constructor(_id, _name, _position) {
        super(_id, _name);
        this.position = _position;
    }
}
const emp = new Employee(3, "Shaun", "Developer");
console.log(emp.name);
console.log(emp.register());
// Generics - basically used to build re-usables
function getArray(items) {
    return new Array().concat(items);
}
let numArray = getArray([1, 2, 3, 4]);
let strArray = getArray(["Bob", "Tick", "Bim"]);
numArray.push(7);
strArray.push("Kat");
// TS with React
// $npx create-react-app myApp --template typescript
