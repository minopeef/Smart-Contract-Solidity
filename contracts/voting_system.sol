// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VoteApp{

    struct Candidate{
        string name;
        uint256 voteCount;
    }

    // variables
    Candidate[] public candidates;
    bool public isVotingStarted;
    bool public isVotingEnded;
    address public admin;
    mapping(address => bool) public isDoneVoting;

    // events
    event candidateAdded(string _name);
    event doneVoting(address indexed voter, uint256 candidateIndex);
    event votingStarted();
    event votingEnded();

    // constructor
    constructor() {
        admin = msg.sender;
    }

    // modifiers
    modifier onlyAdmin(){
        require(msg.sender == admin, "Only Admin can perform this action");
        _;
    }

    modifier whenVotingActive(){
        require(!isVotingEnded && isVotingStarted, "Voting is not active");
        _;
    }

    function getCandidates() public view returns(Candidate[] memory){
        return candidates;
    }

    function addCandidate(string memory _name) public onlyAdmin{
        require(bytes(_name).length > 0, "Candidate name cannot be empty");
        require(!isVotingStarted, "Cannot add candidates after voting started");
        candidates.push(Candidate(_name, 0));
        emit candidateAdded(_name);
    }

    function startVoting() public onlyAdmin{
        require(candidates.length > 0, "No candidates added");
        require(!isVotingStarted, "Voting Started Already");
        isVotingStarted = true;
        emit votingStarted();
    }

    function endVoting() public onlyAdmin {
        require(isVotingStarted && !isVotingEnded, "Voting not Active");
        isVotingEnded = true;
        emit votingEnded();
    }

    function makeVote(uint256 _idx) public whenVotingActive{
        require(!isDoneVoting[msg.sender], "Already Voted");
        require(_idx < candidates.length, "Invalid Candidate");

        candidates[_idx].voteCount += 1;
        isDoneVoting[msg.sender] = true;
        emit doneVoting(msg.sender, _idx);
    }

    function getWinner() public view returns(string memory, uint256){
        require(isVotingEnded, "Voting not Ended");
        uint256 maxVote = 0;
        uint256 winnerIdx = 0;

        for(uint256 i=0; i<candidates.length; i++){
            if(candidates[i].voteCount>maxVote){
                maxVote = candidates[i].voteCount;
                winnerIdx = i;
            }
        }

        return (candidates[winnerIdx].name, maxVote); 
    }
}