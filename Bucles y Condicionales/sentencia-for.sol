// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract bucle_for{

    //suma de 100 primeros numeros

    function suma(uint _numero)public pure returns(uint){
        uint Suma = 0;
        for(uint i = _numero; i <(100+_numero); i++){
            Suma += i;
        }
        return Suma;
    }

    //array dinamico de direcciones
    address[] direcciones;

    //añade una direccion al array
    function asocias()public{
        direcciones.push(msg.sender);
    }
    //comprobar si la direccion esta en el array de direcciones
    function comprobarAsociacion()public view returns(bool, address){
        bool flag = false;
        for( uint i = 0; i < direcciones.length; i++){
            if(direcciones[i] == msg.sender){
                flag = true;
            }
        }return (flag, msg.sender);
    }

    //doble for: suma los 10 primeros facatoriales
    function sumaFac()public pure returns(uint){
        uint total = 0;
        for(uint i = 1; i <= 11; i++){
            uint factorial = 1;
            for(uint j = 2; j <= i+1; j++){
                factorial *= j;
            }
            total += factorial;
        }
        return total;
    }
}