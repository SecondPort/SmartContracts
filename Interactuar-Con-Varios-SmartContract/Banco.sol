// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Banco{
    //Definimos un tipo de dato complejo
    struct cliente{
        string cliente;
        address direccion;
        uint dinero;
    }

    //mapping nos relaciona el nombre del cliente con el tipo de dato cliente
    mapping(string => cliente) clientes;

    //funcion que nos permita dar de alto un nuevo cliente
    function nuevoCliente(string memory _nombre)internal {
        clientes[_nombre] = cliente(_nombre, msg.sender, 0);
    }
}

contract Banco2{

}

contract Banco3{

}