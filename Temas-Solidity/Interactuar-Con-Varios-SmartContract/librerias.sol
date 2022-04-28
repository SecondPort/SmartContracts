// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

library Operaciones{

    function division(uint _i, uint _j)public pure returns(uint){
        require(_j >0, "Error: Division por cero");
        return _i/_j;
    }

    function multiplicacion(uint _i, uint _j)public pure returns(uint){

        if((_i == 0 ) || ( _j == 0)){
            return 0;
        }else{
            return _i*_j;
        }
    }
}

contract calculos{

    using Operaciones for uint;

    function Calculos(uint _a, uint _b)public pure returns(uint,uint){
        uint q = _a.division(_b); //division
        uint m = _a.multiplicacion(_b); //multiplicacion
        return(q,m);
    }
}