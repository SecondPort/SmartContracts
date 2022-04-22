// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract SmartContract1 {

    //almacenamiento de la informacion del factory
    mapping (address => address)public MiContrato;

    function Factory()public {
        address direccion_nuevo_contrato = address(new SmartContract2(msg.sender));
        MiContrato[msg.sender] = direccion_nuevo_contrato;
    }
}

contract SmartContract2{

    address public owner;

    constructor(address _owner)public {
        owner = _owner;
    }
}