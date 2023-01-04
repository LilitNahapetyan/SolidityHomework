//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8 .12;

contract Market {

  address shop = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

  // Define a modifier that allows only the shop address to call functions
  modifier onlyShop {
    require(msg.sender == shop);
    _;
  }
  // Struct for storing a user's shopping data
  struct User {
    string name;
    string surname;
    string[] products;
  }
  mapping(address => User) public users;

  // Function for adding a new user to the market
  function addUser(string memory userName, string memory userSurname) public {

    // Check if the user already exists in the mapping
    require(bytes(users[msg.sender].name).length == 0, "Market: User already exists");

    // Create a new user struct and add it to the mapping
    User memory newUser = User(userName, userSurname, new string[](0));
    users[msg.sender] = newUser;
  }
  
  // Function for adding a new product to a user's shopping list
  function addProduct(string memory product) external onlyShop{
      
    // Check if the user exists in the mapping
    require(bytes(users[msg.sender].name).length != 0, "Market: User does not exist");

    users[msg.sender].products.push(product);
  }

  // Function for retrieving a user's shopping list
  function getUserProducts() external view returns(string[] memory) {
    
    // Check if the user exists in the mapping
    require(bytes(users[msg.sender].name).length != 0,"User does not exist");
    
    return users[msg.sender].products;
  }
}
