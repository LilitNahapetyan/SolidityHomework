//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GameSolidity{
    //get a random number between 0 and 999
    function generateRandomNumber() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 100;
    } 

    function play(uint256 number) public view returns(string memory) {
        if (generateRandomNumber() >= number - 5 && generateRandomNumber() <= number + 5) {
            return "Congratulations!";
        }else{
            return "Try again";
        }
    }
}