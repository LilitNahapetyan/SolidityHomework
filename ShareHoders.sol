// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ShareHolder {
    address private owner;
    mapping(address => uint) private shareholders;
    uint private countOfShareHolders = 0;
    uint private totalPercentage = 0;
    address[] private sharholderList;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You can not do this because you are not owner.");
        _;
    }
   
   // The addShareholder function allows the owner to add a shareholder to the contract
    function addShareholder(address shareholder, uint percentage) public onlyOwner {
        require(percentage > 0 && percentage <= 100, "Percentage must be greater than 0 and less than or equal to 100.");
        totalPercentage += percentage;
        require(totalPercentage <= 100,"You can not add Sharholders with that percentage");
        shareholders[shareholder] = percentage;
        sharholderList.push(shareholder);
        countOfShareHolders ++;
    }

    // The deleteShareholder function allows the owner to remove a shareholder from the contract
    function deleteShareholder(address shareholder) public onlyOwner{
        totalPercentage -= shareholders[shareholder];
        delete shareholders[shareholder];
        countOfShareHolders--;
    }

    function sendFunds() public payable {
        require(msg.value > 0, "Cannot send 0 ether.");
        for(uint i = 0; i < sharholderList.length; i++) {
            uint percentage = shareholders[sharholderList[i]];
            if(percentage != 0) {
                uint share = msg.value * percentage / totalPercentage;
                payable(sharholderList[i]).transfer(share);
            }
        }
    }

    function checkBalance(address shareholder) public view returns(uint){
        return shareholder.balance;
    }
    receive() external payable{
        sendFunds();
    }
}