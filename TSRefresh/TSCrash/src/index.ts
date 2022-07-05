let id: number = 5;
let company: string = "Dinance";
let isPublished: boolean = true
let x: any = "Hello";
let age: number;
age = 23;

let ids: number[] = [1, 2, 3, 4, 5];
let arr: any[] = [1, 2, 'hello', 'world'];
arr.push("Addition");
let person: [number, string, boolean] = [1, "hello", true]
let employee: [number, string][];
employee = [
    [1, "Shawn"],
    [2, 'Kelly'],
    [3, "Nicole"],
    [4, "Brandon"]
]
let pid: string | number; // A Union
pid = "Eben";
pid = "23";

enum Direction {
    Up,
    Down,
    Left,
    Right
}

// Object
type User = {
    id: number,
    name: string
}

const user: User = {
    id: 1,
    name: 'John'
}

// Type Assertion
let cusId: any = 1;
let customerId1 = <number>cusId;
let customerId2 = cusId as string;

// Function
function addNum(x: number, y: number): number {
    return x + y;
}

function log(message: string | number): void { // If no return element, label as void
    console.log(message);
}

// You can also write your function as in JS:
const getFullName = (name: string, surname: string): string => {
    return name + " " + surname;
}
console.log(getFullName("Jeff", "Basel"));

// Interface
interface UserInterface {
    readonly id: number,    // readonly means you can't assign another value later on
    name: string,
    age?: number    // The sign "?" makes the variable optional
}

const user2: UserInterface = {
    id: 1,
    name: 'John'
}

interface MathFunc {
    (x: number, y: number): number;
}

const add: MathFunc = (x: number, y: number): number => x + y;
const sub: MathFunc = (x: number, y: number): number => x - y;

// Classes
class Person {
    id: number;
    name: string;

    constructor(_id: number, _name: string) {
        this.id = _id;
        this.name = _name;
    }
}
const brad = new Person(1, "brad");

/**
 * We can get the class to implement an Interface
*/
interface PersonInterface {
    id: number,
    name: string,
    register(): string
}
class MyPerson implements PersonInterface {
    id: number;
    name: string;
    constructor(_id: number, _name: string) {
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
    position: string;
    constructor(_id: number, _name: string, _position: string) {
        super(_id, _name);
        this.position = _position;
    }
}

const emp = new Employee(3, "Shaun", "Developer");
console.log(emp.name);
console.log(emp.register());

// Generics - basically used to build re-usables
function getArray<T>(items: T[]): T[] {
    return new Array().concat(items);
}

let numArray = getArray<number>([1, 2, 3, 4])
let strArray = getArray<string>(["Bob", "Tick", "Bim"])

numArray.push(7);
strArray.push("Kat");

// TS with React
// $npx create-react-app myApp --template typescript