// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CrowdFundingPlatform{
    // Structs
    struct BackersList{
        address donateBy;
        uint256 amount;
    }

    struct Campaign{
        address _creator;
        uint256 _goal;
        uint256 _deadline;
        uint256 _amtRaised;
        bool isCompleted;
        BackersList[] backers;
    }

    // State Variables
    Campaign[] public totalCampaign;    

    // Events 
    event CampaignCreated(uint256 campaignId, address _creator, uint256 _goal, uint256 _deadline);
    event EthDonated(address _from, uint256 campaignId, uint256 amt);
    event Refund();
    event Payout();

    // Functions
    // Create a Campaign 
    function createCampaign(uint256 _goal, uint256 _deadline) public {
        totalCampaign.push(); // Push an empty campaingn
        uint256 campaignId = totalCampaign.length - 1;

        // Filling values in the empty campaign
        Campaign storage newCampaign = totalCampaign[campaignId];
        newCampaign._creator = msg.sender;
        newCampaign._deadline = _deadline;
        newCampaign._goal = _goal;
        newCampaign._amtRaised = 0;
        newCampaign.isCompleted = false;

        emit CampaignCreated(campaignId, msg.sender, _goal, _deadline);
    } 

    // donate eth to campaign 
    function donate(uint256 campaignId) external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        require(campaignId < totalCampaign.length, "Invalid Campaign Id");
        require(totalCampaign[campaignId]._deadline >= block.timestamp, "Deadline Passed");
        require(!totalCampaign[campaignId].isCompleted, "Campaign is completed");

        totalCampaign[campaignId].backers.push(BackersList(msg.sender, msg.value));
        totalCampaign[campaignId]._amtRaised += msg.value;

        emit EthDonated(msg.sender, campaignId, msg.value);
    }

    // refund if goal is not reached and deadline passed
    function refund(uint256 campaignId) external {
        Campaign storage getCampaign = totalCampaign[campaignId];
        require(getCampaign._deadline < block.timestamp, "Deadline not passed");
        require(getCampaign._amtRaised < getCampaign._goal, "Goal reached, cannot refund");
        require(!getCampaign.isCompleted, "Already processed");

        getCampaign.isCompleted = true;
        uint256 len = getCampaign.backers.length;

        for(uint256 i = 0; i < len; i++){
            BackersList storage getBackers = getCampaign.backers[i];
            (bool success, ) = payable(getBackers.donateBy).call{value: getBackers.amount}("");
            require(success, "Transfer failed");
        }

        emit Refund();
    }

    // payout
    function getFundsToCreator(uint256 _id) external {
        Campaign storage getCampaign = totalCampaign[_id];
        require(getCampaign._creator == msg.sender, "Only campaign creator can get the payout");
        require(getCampaign._deadline < block.timestamp, "Campaign is Active");
        require(getCampaign._amtRaised >= getCampaign._goal, "Goal not reached");
        require(!getCampaign.isCompleted, "Already processed");

        getCampaign.isCompleted = true;
        (bool success, ) = payable(msg.sender).call{value: getCampaign._amtRaised}("");
        require(success, "Transfer failed");

        emit Payout();
    }

    // get campaign details
    function getCampaignDetails(uint256 campaignId) public view returns(Campaign memory){
        return totalCampaign[campaignId];
    }
}