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

contract Cliente is Banco{

    function AltaCliente(string memory _nombre)public {
        nuevoCliente(_nombre);
    }

    function Ingresar(string memory _nombre, uint _cant)public{
        clientes[_nombre].dinero += _cant;
    }

    function Retirar(string memory _nombre, uint _cant)public returns(bool){
        bool flag = true;

        if(int(clientes[_nombre].dinero) - int( _cant) >= 0){
            clientes[_nombre].dinero -= _cant;
        }else{
            flag = false;
        }return flag;
    }

    function ConsultarSaldo(string memory _nombre)public view returns(uint){
        return clientes[_nombre].dinero;
    }
}