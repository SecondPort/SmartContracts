/// @title First contract
/// @dev This contract is used to test the deployment of multiple contracts.
/// @author SecondPort
// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;  /* version */
import "./ERC20.sol";

contract First {

    address owner;// variable que tiene la direccion de quien despliega el contrato
    ERC20Basic token;
    constructor() public{
        owner = msg.sender; //dirreccion del remitente
        token = new ERC20Basic(1000);// cantidad de tokens a desplegar
    }
}