// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
* @title ShareHolder
* @dev this contract adds and removes users by the owner and transfer ether to
* users according to their percentage.(for not keeping ether in the contract)
*/

contract ShareHolders {

    mapping(address => uint8) shareholders;
    uint8 public totalPercentage;
    address payable[] shareholderList;

    /**
    * The constructor initializes the owner.
    */
    address owner;
    constructor(address  _owner){
        owner = _owner;
    }
 
     /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner {
        require(msg.sender == owner, "ShareHolder: You can not do this because you are not the owner.");
        _;
    }
    
    /**
    * @dev receives ether and call sendfunds function.
    */
    receive() external payable {
        sendFunds();
        // for(uint256 _index; _index < shareholderList.length; _index++) {
        //     shareholderList[_index].transfer((address(this).balance * shareholders[shareholderList[_index]]) / 100);
        // }
    }
   
    /**
    * @dev adds users.
    * Note: the use of onlyOwner ensures that this function can call only owner.
    * @param _shareholder the address of the user that should be added.
    * @param _percentage the percentage that the user should receive from the amount.
    */
    function addShareholder(address payable _shareholder, uint8 _percentage) external onlyOwner {
        require(totalPercentage + _percentage <= 100, "ShareHolder: You can not add Sharholders with that percentage");
        totalPercentage += _percentage;
        shareholders[_shareholder] = _percentage;
        shareholderList.push(_shareholder);
    }

    /**
    * @dev removes users.
    * Note: the use of onlyOwner ensures that this function can call only owner.
    * @param _shareholder the address of the user that should be removed.
    */
    function deleteShareholder(address _shareholder) external onlyOwner{
        require(shareholders[_shareholder] > 0, "ShareHolder: This user has 0 percentage or does not exist");
        totalPercentage -= shareholders[_shareholder];
        delete shareholders[_shareholder];
        for(uint256 i; i < shareholderList.length; i++){
            if(shareholderList[i] == _shareholder){
                shareholderList[i] = shareholderList[shareholderList.length-1];
                shareholderList.pop();
                break;
            }
        }
    }

    /**
    * @dev returns balance of contract.
    */
    function checkBalance() external view returns(uint) {
        return address(this).balance;
    }

    /**
    * @dev sends ethers to users corresponding to their percentage.
    */
    function sendFunds() private {
        for(uint8 i; i < shareholderList.length; i++) {
            uint8 percentage = shareholders[shareholderList[i]];
            shareholderList[i].transfer(address(this).balance * percentage / 100);
        }
    }
}

