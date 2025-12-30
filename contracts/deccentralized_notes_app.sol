// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract NotesApp{
    struct Note{
        uint256 idx;
        string title;
        string content;
        bool isDeleted;
        uint256 timeStamp; // block.timestamp -> gets the current time 
    }

    // Variables
    mapping(address => Note[]) private savedNotes;

    // Events
    event noteAdded(address _user, string _title, uint256 _idx);
    event noteUpdated(address _user, uint256 _idx, string _title, string _content);
    event noteDeleted(address _user, uint256 _idx);

    // Functions
    // Add a new note
    function addNote(string memory _title, string memory _content) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        uint256 _idx = savedNotes[msg.sender].length;
        savedNotes[msg.sender].push(Note(_idx, _title, _content, false, block.timestamp));
        emit noteAdded(msg.sender, _title, savedNotes[msg.sender].length - 1);
    }

    // Update a particular note
    function updateNote(uint256 _idx, string memory _title, string memory _content) public {
        require(_idx < savedNotes[msg.sender].length, "Invalid Index");
        require(!savedNotes[msg.sender][_idx].isDeleted, "Note Deleted");
        require(bytes(_title).length > 0, "Title cannot be empty");

        savedNotes[msg.sender][_idx].title = _title;
        savedNotes[msg.sender][_idx].content = _content;
        savedNotes[msg.sender][_idx].timeStamp = block.timestamp;

        emit noteUpdated(msg.sender, _idx, _title, _content);
    }

    // Deleting a particular note
    function deleteNote(uint256 _idx) public {
        // checking conditions
        require(_idx < savedNotes[msg.sender].length, "Invalid Index");
        require(!savedNotes[msg.sender][_idx].isDeleted, "Note Already Deleted!");

        // deleting the note softly 
        savedNotes[msg.sender][_idx].isDeleted = true;

        // emitting events
        emit noteDeleted(msg.sender, _idx);
    }

    // Getting all the notes except the deleted ones
    function getAllNotes() public view returns(Note[] memory){
        uint256 totalNotes = savedNotes[msg.sender].length;
        if(totalNotes == 0) {
            return new Note[](0);
        }

        // Getting the count of the not deleted total notes
        uint256 count = 0;
        for(uint256 i = 0; i < totalNotes; i++){
            if(!savedNotes[msg.sender][i].isDeleted){
                count++;
            }
        }

        // creating a new array of notes
        Note[] memory activeNotes = new Note[](count);
        uint256 index = 0;

        // assigning the values into the new array 
        for(uint256 i = 0; i < totalNotes; i++){
            if(!savedNotes[msg.sender][i].isDeleted){
                activeNotes[index] = savedNotes[msg.sender][i];
                index++;
            }
        }

        return activeNotes;
    }
}