// SPDX-License-Identifier: MIT
pragma solidity >0.4.0;
pragma experimental ABIEncoderV2;
import "../Trabajo-Final/Tools/OperacionesBasicas.sol";
import "../Trabajo-Final/Tools/ERC20.sol";

//contrato para la compañia de seguro
contract InsuranceFactory is OperacionesBasicas{

    constructor() public{
        token = new ERC20(100);
        Insurance = address(this);
        Aseguradora = msg.sender;
    }

    //intancia del contrato token
    ERC20Basic private token;

    //declaracion de las direcciones
    address Insurance; //direccion del contrato
    address payable public Aseguradora;

    address[] ClientesAsegurados;
}