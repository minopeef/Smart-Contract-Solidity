// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

struct Task{
    string taskName;
    bool isCompleted;
}

contract TodoApp{
    mapping(address => Task[]) public tasksList;

    // Events
    event TaskAdded(address indexed user, uint256 taskId, string taskName);
    event TaskUpdated(address indexed user, uint256 taskId, string newTaskName);
    event TaskCompleted(address indexed user, uint256 taskId);

    function addTask(string memory _taskName) public {
        require(bytes(_taskName).length > 0, "Task name cannot be empty");
        tasksList[msg.sender].push(Task(_taskName, false));
        emit TaskAdded(msg.sender, tasksList[msg.sender].length - 1, _taskName);
    }

    function getTask() public view returns (Task[] memory){
        return tasksList[msg.sender];
    }

    function markTaskAsCompleted(uint256 _taskId) public {
        require(_taskId < tasksList[msg.sender].length, "Invalid task ID");
        require(!tasksList[msg.sender][_taskId].isCompleted, "Task already completed");
        tasksList[msg.sender][_taskId].isCompleted = true;
        emit TaskCompleted(msg.sender, _taskId);
    }

    function updateTask(uint256 _taskId, string memory _newTask) public {
        require(_taskId < tasksList[msg.sender].length, "Invalid task ID");
        require(bytes(_newTask).length > 0, "Task name cannot be empty");
        tasksList[msg.sender][_taskId].taskName = _newTask;
        emit TaskUpdated(msg.sender, _taskId, _newTask);
    }
}