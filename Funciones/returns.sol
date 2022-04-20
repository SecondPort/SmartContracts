pragma solidity 0.8.13;

contract ValoresDeRetorno{

    //funcion que nos devuelva un saludo
    function saludos()public returns(string memory){
        return "Hola";
    }

    //funcion que devuelva la multiplicacion
    function multiplicacion(uint _a, uint _b)public returns(uint){
        return _a * _b;
    }

    //funcion para determinar si es par o no un numero
    function par_impar(uint _a)public returns(bool){
        bool flag;
        if(_a%2 == 0){
            flag = true;
        }else{
            flag = false;
        }
        return flag;
    }

    //funcion division que retorna el cociente y el resto de una division ademas de una variable bool si el resto es 0 es true
    function division(uint _a, uint _b)public returns(uint, uint, bool){
            uint _q = _a / _b;
            uint _r = _a % _b;
            bool multiplo;
            if(_a % _b == 0){
                multiplo = true;
        }else{
                multiplo = false;
            }
            return (_q, _r, multiplo);
    }

    //practica para el manejo de los valores devueltos

    function numeros() public returns(uint, uint, uint,uint, uint){
        return (1, 2, 3, 4, 5);
    }

    //asignacion multiple de valores
}