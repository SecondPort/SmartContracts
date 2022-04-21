// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;

contract Eventos{

    //Declarar los eventos a utilizar
    event nombre_evento1(string _nombre);
    event nombre_evento2(string _nombre, uint edad);
    event nombre_evento3(string, uint, address, bytes32);
    event abortarmision();

    function EmitirEvento1(string memory _nombre)public{
        emit nombre_evento1(_nombre);
    }

    function EmitirEvento2(string memory _nombre, uint _edad)public{
        emit nombre_evento2(_nombre, _edad);
    }

    function EmitirEvento3(string memory _nombre, uint _edad)public{
        bytes32 _hashId = keccak256(abi.encodePacked(_nombre, _edad, msg.sender));
        emit nombre_evento3(_nombre, _edad, msg.sender, _hashId);
    }

    function AbortarMision()public{
        emit abortarmision();
    }
}