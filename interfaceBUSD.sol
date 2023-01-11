// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
//0xeD24FC36d5Ee211Ea25A80239Fb8C4Cfd80f12Ee
interface interfaceBUSD{
    function name() external view returns(string memory);
    // function totalSupply() external view returns (uint256);
    // function balanceOf(address tokenOwner) external view returns (uint256);
    // function transfer(address to, uint256 value) external returns (bool);
    // function decimals() external returns(uint8);
}

contract callInterface {
    address payable bUSDContractAddress;

    constructor(address payable _bUSDContractAddress) {
        //require(address(_bUSDContractAddress).isContract(), "bUSDContractAddress is not a contract address");
        bUSDContractAddress = _bUSDContractAddress;
    }

    function getName() public returns (string memory) {
        (bool success, bytes memory data) = bUSDContractAddress.delegatecall(abi.encodeWithSignature("name()"));
        require(success, "delegatecall failed");
        (string memory name) = abi.decode(data, (string));
        return name;
    }
}
