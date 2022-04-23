// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;

contract Require{

    //funcion que verifique la contraseña
    function password(string memory _password)public pure returns(string memory){
        require( keccak256(abi.encodePacked(_password)) == keccak256(abi.encodePacked("12345")), "Password incorrecto");
        return "Contrasenia correcta";
    }

    //funcion para pagar
    uint tiempo = 0;
    uint public cartera = 0;
    function pagar(uint _dinero)public returns(uint){
        require(block.timestamp > tiempo + 5 seconds, "No puedes pagar");
        tiempo = block.timestamp;
        cartera += _dinero;
        return cartera;
    }

    //funcion con una lista

    string[] nombres;

    function nuevoNombre(string memory _nombre)public{
        for(uint i = 0; i < nombres.length; i++){
            require(keccak256(abi.encodePacked(_nombre)) != keccak256(abi.encodePacked(nombres[i])), "El nombre ya existe");
        }
        nombres.push(_nombre);
    }
}