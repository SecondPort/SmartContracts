// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


contract tiempo {
    //unidades de tiempo
    uint public tiempo_actual = block.timestamp;// tiempo actual en unidades de tiempo
    uint public un_minuto = 1 minutes;
    uint public dos_horas = 2 hours;
    uint public dias = 50 days;
    uint public semanas = 4 weeks;

    function MasSegundos()public view returns(uint){
        return block.timestamp + 50 seconds;
    }

    function MasMinutos()public view returns(uint){
        return block.timestamp + 1 minutes;
    }
    function MasHoras()public view returns(uint){
        return block.timestamp + 1 hours;
    }
    function MasDias()public view returns(uint){
        return block.timestamp + 1 days;
    }
    function MasSemanas()public view returns(uint){
        return block.timestamp + 1 weeks;
    }
}