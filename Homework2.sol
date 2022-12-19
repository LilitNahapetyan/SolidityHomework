//2․ Create a game in the following format: have a function that returns
// a random number (this function can only be called inside of a contract) 
//and another function that allows users to enter a number. If the number 
//entered by the user and the randomly generated number are within +- 5 of 
//each other, then congratulate the user, otherwise encourage for participation.
contract Game {
    uint256 private randomNumber;
    string public result;
    
    //get a random number between 0 and 999
    function generateRandomNumber() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 100;
    } 

    function play(uint256 number) public {
        randomNumber = generateRandomNumber();
        if (randomNumber > number - 5 && randomNumber < number + 5) {
            result = "Congratulations!";
        }else{
            result = "Try again";
        }
    }
}