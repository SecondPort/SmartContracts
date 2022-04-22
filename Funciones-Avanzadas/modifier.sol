// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Modifier{

    //ejemplo de solo propietario puede ejecutar una funcion

    address public owner;

    constructor (){
        owner = msg.sender;
    }

    modifier soloPropietario(){
        require(msg.sender == owner, "Solo el propietario puede ejecutar esta funcion");
        _;
    }

    function ejemplo1()public soloPropietario(){
        //codigo de la funcion para el propietario
    }

    struct cliente{
        address direccion;
        string nombre;
    }

    mapping(string => address) public clientes;

    function altaCliente(string memory _nombre)public{
        clientes[_nombre] = msg.sender;
    }

    modifier soloClientes(string memory _nombre){
        require(clientes[_nombre] == msg.sender, "Solo el cliente puede ejecutar esta funcion");
        _;
    }

    function ejmplo2(string memory _nombre)public soloClientes(_nombre){
        //codigo de la funcion para el cliente
    }

    //Ejemplo de conduccion

    modifier MayorEdad(uint _edadMinima, uint _edadUsuario){
        require(_edadUsuario >= _edadMinima, "El usuario debe ser mayor de edad");
        _;
    }

    function conduciru(uint _edad)public MayorEdad(18, _edad){
        //codigo de la funcion para el cliente
    }

}