//indicar la version
pragma solidity 0.8.13;
pragma experimental ABIEncoderV2;

contract hash{

    // computo del hash de un string
    function calcularHash(string memory _cadena) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_cadena));
    }
    //computo del hash de un string, un entero y una direccion
    function calcularHash2(string memory _cadena, uint _k, address _direccion) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_cadena, _k, _direccion));
    }
    //computo del hash de un string, un entero y una direccion mas otro string y entero que no estan dentro de la variable
    function calcularHash3(string memory _cadena, uint _k, address _direccion) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_cadena, _k, _direccion, "hola"));
    }
}