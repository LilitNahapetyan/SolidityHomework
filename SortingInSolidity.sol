//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SortingInSolidity{
    function mergeSort(int[] memory array) internal pure returns(int[] memory){
        if(array.length <= 1){
            return array; 
        }
        int[] memory left = new int[](array.length/2);
        int[] memory right = new int[](array.length - array.length/2);

        for(uint i = 0; i < array.length/2;i++){
            left[i] = array[i];
        }
        for(uint i = 0; i < array.length - array.length/2;i++){
            right[i] = array[array.length/2 + i];
        }
        return merge(mergeSort(left),mergeSort(right));
    }

    function merge(int[] memory firstHalf,int[] memory secondHalf) internal pure returns(int[] memory){
        int[] memory result = new int[](firstHalf.length + secondHalf.length);
        uint i = 0;
        uint j = 0;
        uint res = 0;
        while(i < firstHalf.length && j < secondHalf.length){
            if(firstHalf[i] > secondHalf[j]){
                result[res] = secondHalf[j];
                j++;
            }else{
                result[res] = firstHalf[i];
                i++;
            }
            res++;
        }
        while(i < firstHalf.length){
            result[res] = firstHalf[i];
            res++;
            i++;
        }
        while(j < secondHalf.length){
            result[res] = secondHalf[j];
            res++;
            j++;
        }

    return result;
    }

    function getNLargestElement(int[] memory array,uint n) pure public returns(int[] memory){
        array = mergeSort(array);
        if(n > array.length){
            n = array.length;
        }
        int[] memory largestElements = new int[](n);
        for(uint i = 0; i < n; i++){
            largestElements[i] = array[array.length - i - 1];
        }
        return largestElements;
    }
}