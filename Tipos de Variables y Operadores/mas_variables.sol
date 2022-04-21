// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma experimental ABIEncoderV2;

contract mas_variables{

    //variables string
    string myString;
    string public myStringInicializado = "Hola";
    string public vacio = "";

    //variables bool
    bool myBool;
    bool public myBoolInicializado = true;
    bool public myBoolInicializadoFalse = false;

    //variables bytes
    bytes32 myBytes;
    bytes4 myBytes4;
    string public nombre = "Lucas";
    bytes32 public hash = keccak256(abi.encodePacked(nombre));
    bytes4 public id;

    function ejemploBytes4()public{
        id = msg.sig;
    }

    //variable address
    address myAddress;
    address public myAddressInicializado = 0x1234567890123456789012345678901234567890;
    address public myAddressInicializado2 = 0x0000000000000000000000000000000000000000;
}