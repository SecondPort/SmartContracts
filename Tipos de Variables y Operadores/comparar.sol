pragma solidity 0.8.13;
pragma experimental ABIEncoderV2;

contract compararStrings{

    function comparar(string memory _j, string memory _i)public view returns(bool){

        if(hash_i(keccak256(abi.encodePacked(_i))) == hash_j(keccak256(abi.encodePacked(_j)))){
            return true;
        }
        else{
            return false;
        }
    }
}