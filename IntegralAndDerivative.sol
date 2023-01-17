//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
* @title Integral
* @dev this contract allows for the calculation of integrals and derivatives of polynomials.
*/
import "@openzeppelin/contracts/utils/Strings.sol";
contract Integral {
    using Strings for uint256;
    /**
    * @dev divide two integers and return a tuple of quotient and remainder
    * @param a is the dividend
    * @param b is the divisor
    */
    function divide(uint a, uint b) private pure returns (uint,uint) {
        uint i = 10**10;
        uint quotient = a / b;
        uint reminder = (a - quotient * b) * i / b;
        return (quotient,reminder);
    }


    /**
    *@dev calculate definite integral of the polynomial
    *Note:  This function uses the "divide" function to calculate the definite integral of 
    *@param arr is polynomial (coefficient,degree)
    *@param upper is upper edge
    *@param lower is lower edge
    *the polynomial between the upper and lower bounds passed in as arguments.
    */
    function countIntegral(uint[] memory arr,uint upper,uint lower) external pure returns(string memory){
        require(arr.length % 2 == 0,"You must input arr's value this way - (coefficient,degree)");
        uint quotient = 0;
        uint reminder = 0;
        for(uint i = 0; i<arr.length - 1;i+=2){
            (uint first,uint second) = divide(arr[i] * upper ** (arr[i + 1] +1),uint(arr[i + 1] + 1));
             quotient += first;
             reminder += second;
             (uint a,uint b) = divide(arr[i] * lower ** (arr[i + 1] +1),uint(arr[i + 1] + 1));
             quotient -= a;
             reminder -= b;
             if(reminder / (10**10) !=0){
                 quotient += 1;
                 reminder %= 10**10;
             }
        }
        return string(abi.encodePacked(quotient.toString(), ".", reminder.toString()));
    }

    /**
    *@dev calculates the derivative of the polynomial at the point x
    *@param arr is polynomial (coefficient,degree)
    *@param x is the point
    */
    function derivative(uint[] memory arr,uint x) external pure returns(uint){
        require(arr.length % 2 == 0,"You must input arr's value this way - (coefficient,degree)");
        uint resultOfDerivative = 0;
        for(uint i = 0; i<arr.length - 1;i+=2){
            resultOfDerivative += arr[i] * uint(arr[i + 1]) * uint(x ** (arr[i + 1]-1));
        }
        return resultOfDerivative;
    }
}