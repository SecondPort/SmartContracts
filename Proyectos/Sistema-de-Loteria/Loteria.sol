// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;
import "./SafeMath.sol";
import "./ERC20.sol";

contract loteria{

    //intancia del contrato Token
    ERC20Basic private token;

    //direcciones
    address public owner;
    address public contrato;

    //variable para el numero de tokens a crear
    uint public tokens_creados = 10000;

    constructor()public{
        token = new ERC20Basic(tokens_creados);
        owner = msg.sender;
        //con this hacemos referencia al contrato
        contrato = address(this);
    }

    //---------------------- TOKEN ----------------------------

    //establecer precio al token
    function PrecioTokens(uint _numTokens)internal pure returns(uint){
        return _numTokens*(1 ether);
    }



}