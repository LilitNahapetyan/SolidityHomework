//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

/**
* @title Integral
* @dev this contract allows for the calculation of integrals and derivatives of polynomials.
*/
contract Integral {
    int[] coefficients;
    uint[] degrees;
    

    /**
    * @dev divide two integers and return a tuple of quotient and remainder
    * @param a is the dividend
    * @param b is the divisor
    */
    function divide(int a, int b) public pure returns (int,int) {
        int i = 10**10;
        int quotient = a / b;
        int reminder = (a - quotient * b) * i / b;
        return (quotient,reminder);
    }

    /**
    * @dev set the coefficients and degrees of the polynomial
    */
    function setCoefficient(int coefficient, uint degree) public{
        coefficients.push(coefficient);
        degrees.push(degree);
    }

    /**
    *@dev calculate definite integral of the polynomial
    *Note:  This function uses the "divide" function to calculate the definite integral of 
    *@param upper is upper edge
    *@param lower is lower edge
    *the polynomial between the upper and lower bounds passed in as arguments.
    */
    function countIntegral(int upper,int lower) public view returns(int,int){
        int quotient = 0;
        int reminder = 0;
        for(uint i = 0; i<coefficients.length;i++){
            (int first,int second) = divide(coefficients[i] * upper ** (degrees[i] +1),int(degrees[i] + 1));
             quotient += first;
             reminder += second;
             (int a,int b) = divide(coefficients[i] * lower ** (degrees[i] +1),int(degrees[i] + 1));
             quotient -= a;
             reminder -= b;
             if(reminder / (10**10) !=0){
                 quotient += 1;
                 reminder %= 10**10;
             }
        }
        return (quotient,reminder);
    }

    /**
    * @dev calculates the derivative of the polynomial at the point x
    *@param x is the point
    */
    function derivative(uint x) public view returns(int){
         int resultOfDerivative = 0;
        for(uint i = 0; i<coefficients.length;i++){
            resultOfDerivative += coefficients[i] * int(degrees[i]) * int(x ** (degrees[i]-1));
            
        }
        return resultOfDerivative;
    }
}