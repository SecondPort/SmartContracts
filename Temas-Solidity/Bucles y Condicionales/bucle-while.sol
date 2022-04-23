// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract bucle_while{

    //suma de los numeros impares menores a 100
    function suma_impares()public pure returns(uint){
        uint suma = 0;
        uint contador = 1;
        while(contador <= 100){
            if(contador % 2 != 0){
                suma += contador;
            }
            contador++;
        }return suma;
    }

    //esperar 10 segundos

    uint tiempo;

    function fijarTiempo()public{
        tiempo = block.timestamp;
    }

    function espera()public view returns(bool){
        while(block.timestamp < tiempo + 5 seconds){
            return false;
        }return true;
    }

    //devolver el numero primo a partir de un numero
    //numero primo es un numero que solo es divisible por 1 y por si mismo

    function siguienrePrimo(uint _p)public pure returns(uint){
        uint contador = _p + 1;
        while(true){
            if(esPrimo(contador)){
                return contador;
            }
            contador++;
        }return contador;
    }

    function esPrimo(uint _p)private pure returns(bool){
        uint contador = 2;
        while(contador < _p){
            if(_p % contador == 0){
                return false;
            }
            contador++;
        }return true;
    }

/*     function siguientePrimo(uint _p)public pure returns(uint){
        uint contador = _p + 1;
        while(true){
            /comprobamos si contador es primo
            uint aux = 2;
            bool primo = true;
            while(aux < contador){
                if(contador % aux == 0){
                    primo = false;
                    break;
                }aux++;
            }
            if (primo == true){
                break;
            }contador++;
        }return contador;
    } */


}