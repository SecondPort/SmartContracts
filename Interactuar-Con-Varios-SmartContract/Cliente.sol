// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

//import {Banco} from "./Banco.sol";
import "./Banco.sol";

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