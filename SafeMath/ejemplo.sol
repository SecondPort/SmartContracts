// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "./SafeMath.sol";

contract calculosSeguros{

    //debemos declarar para que tipo de datos usaremos la libreria
    using SafeMath for uint256;

    //funcion suma
    function suma(uint _a, uint _b)public pure returns(uint){
        return _a.add(_b);
    }

    //funcion resta
    function resta(uint _a, uint _b)public pure returns(uint){
        return _a.sub(_b);
    }

    //funcion multiplicar
    function multiplicar(uint _a, uint _b)public pure returns(uint){
        return _a.mul(_b);
    }
}