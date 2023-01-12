// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
* @title BUSDinterface
* This code defines an interface called "interfaceBUSD" which 
* outlines several functions that a smart contract implementing this interface should have.
*/
interface interfaceBUSD{
    /**
    * @dev Returns the name of the token as a string
    */
    function name() external view returns(string memory);
    
    /**
    * @dev Returns the total supply of the token as a uint256
    */
    function totalSupply() external view returns (uint256);

    /**
    * @dev Returns the balance of the token for the specified address
    * @param tokenOwner address of the token owner
    */
    function balanceOf(address tokenOwner) external view returns (uint256);

     /**
    * @dev Allows for the transfer of tokens from one address to another
    * @param to address of the recipient
    * @param value amount of tokens to transfer
    * @return bool indicating success or failure of the transfer
    */
    function transfer(address to, uint256 value) external returns (bool);
    
     /**
    * @dev Returns the number of decimal places used by the token as a uint8
    */
    function decimals() external returns(uint8);
}

/**
*@dev this contract takes an address of a smart contract as an input in its constructor, then provides a number of 
*functions that allow the user to interact with the smart contract at the provided address by calling the functions 
*defined in the interfaceBUSD interface.
*/
contract callInterface {
    address bUSDContractAddress;

    /**
    * @dev constructor that takes an address of a smart contract as an input
    * @param _bUSDContractAddress address of the smart contract to interact with
    */
    constructor(address _bUSDContractAddress) {
        bUSDContractAddress = _bUSDContractAddress;
    }

    function getName() public view returns (string memory) {
        return interfaceBUSD(bUSDContractAddress).name();
    }

    function getTotalSupply() public view returns(uint256){
        return interfaceBUSD(bUSDContractAddress).totalSupply();
    }

    function getBalanceOf(address tokenOwner) public view returns(uint256){
        return interfaceBUSD(bUSDContractAddress).balanceOf(tokenOwner);
    }

    function doTransfer(address to, uint256 value) public returns(bool){
        return interfaceBUSD(bUSDContractAddress).transfer(to,value);
    }

    function getDecimals() public returns(uint8){
         return interfaceBUSD(bUSDContractAddress).decimals();
    }
}
