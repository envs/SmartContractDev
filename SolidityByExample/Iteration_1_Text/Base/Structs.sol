//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string memory _text) public {
        // 3 ways to initialize a struct
        todos.push(Todo(_text, false)); // Calling it like a function
        todos.push(Todo({text: _text, completed: false})); // Key value mapping
        Todo memory todo; // Initialize an empty struct and then update it
        todo.text = _text;
        todos.push(todo);
    }

    // Solidity automatically create a getter for 'todos', so you don't need the function below
    function get(uint256 _index)
        public
        view
        returns (string memory text, bool completed)
    {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // Update text
    function update(uint256 _index, string memory _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // Update completed
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
