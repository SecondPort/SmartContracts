pragma solidity >=0.4.4 <0.7.0;

contract tiempo {
    //unidades de tiempo
    uint public tiempo_actual = now;// tiempo actual en unidades de tiempo
    uint public un_minuto = 1 minutes;
    uint public dos_horas = 2 hours;
    uint public dias = 50 days;
    uint public semanas = 4 weeks;

    function MasSegundos()public view returns(uint){
        return now + 50 seconds;
    }

    function MasMinutos()public view returns(uint){
        return now + 1 minutes;
    }
    function MasHoras()public view returns(uint){
        return now + 1 hours;
    }
    function MasDias()public view returns(uint){
        return now + 1 days;
    }
    function MasSemanas()public view returns(uint){
        return now + 1 weeks;
    }
}