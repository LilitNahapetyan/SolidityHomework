//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

interface IShareHolder{
    function addShareholder(address payable _shareholder, uint8 _percentage) external;
}

/**
* @title OrganizeElections
* @dev contract allows candidates to add themselves to a list of candidates 
* by sending a certain amount of ether to the contract, and allows voters to 
* vote for a candidate on the list.
*/
contract OrganizeElections{

     address owner = msg.sender;

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner {
        require(msg.sender == owner, "OrganizeElections: You can not do this because you are not the owner.");
        _;
    }

    address payable[] private condidatesList; 
    mapping(address=>uint8) private condidates;
    mapping(address => bool) private voted;
    uint8 public totalVotes;
    uint value;
    uint public startTime;
    uint public endTime;
    constructor() {
        value = 10 ether;
        startTime = block.timestamp;
        endTime = startTime + 100 seconds;
    }

    /**
    * @dev Allows candidate to add themselves to the list of candidates
    * Note: msg.value is the amount of ether sent by the candidate
    */
    function addCondidate() public payable{
        require(msg.value >= value, "Elections: Your balance is law for becoming a condidate.");
        require(condidates[msg.sender] == 0, "Elections: You have already become a condidate.");
        condidatesList.push(payable(msg.sender));
        condidates[msg.sender]++;
        voted[msg.sender] = true;
        totalVotes += 1;
    }

    /**
    * @dev Allows voter to vote for a candidate on the list
    * @param _condidate address of the candidate being voted for
    */
    function vote(address _condidate) public{
        require(block.timestamp < endTime, "Elections: Voting period has ended.");
        require(voted[msg.sender] == false, "Elections: You have already voted.");
        require(condidates[_condidate] > 0, "Elections: This condidate does not exist or has not sent any ether.");
        condidates[_condidate] += 1;
        voted[msg.sender] = true;
        totalVotes += 1;
    }
    /**
    * @dev Ends the election and distributes the percentage of votes each candidate received
    * @param _shareholders address of the contract that implements the IShareHolder interface
    */
    function endElections(address payable _shareholders) public onlyOwner{
        require(block.timestamp >= endTime, "Elections: Voting period has not ended yet.");
        for(uint i; i < condidatesList.length; i++){
            uint8 percentage = (100 * condidates[condidatesList[i]] / totalVotes);
            IShareHolder(_shareholders).addShareholder(condidatesList[i],percentage);
        }
        (bool sent,) = _shareholders.call{value: address(this).balance}("");
        require(sent, "Election: Failed!");
    }
}