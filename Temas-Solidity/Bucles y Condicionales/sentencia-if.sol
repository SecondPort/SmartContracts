// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;

contract sentencia_if{

    //dar un numero ganador
    function probarSuerte(uint _numero)public pure returns(bool) {
        bool ganador;
        if(_numero == 1) {
            ganador = true;
        } else {
            ganador = false;
        }
        return ganador;
    }

    //calcular valor absoluto
    function valorAbsoluto(int _numero)public pure returns(uint){
        uint valor_absoluto;
        if(_numero < 0) {
            valor_absoluto = uint(_numero * -1);
        } else {
            valor_absoluto = uint(_numero);
        }
        return valor_absoluto;
    }

    //devolver true si el numero es par y tiene tres cifras
    function esParTresCifras(uint _numero)public pure returns(bool,uint){
        bool flag;

        if(_numero % 2 == 0 && _numero > 99 && _numero < 1000) {
            flag = true;
        } else {
            flag = false;
        }
        return (flag, _numero);
    }

    //votacion
    //solo hay tres candidatos lucas,matias,manuel

    function votar(string memory _candidato)public pure returns(string memory){
        string memory mensaje;

        if(keccak256(abi.encodePacked(_candidato)) == keccak256("lucas")) {
            mensaje = "se voto a Lucas";
        } else if(keccak256(abi.encodePacked(_candidato)) == keccak256("matias")) {
            mensaje = "se voto a Matias";
        } else if(keccak256(abi.encodePacked(_candidato)) == keccak256("manuel")) {
            mensaje = "se voto a Manuel";
        } else {
            mensaje = "candidato no encontrado";
        }
        return mensaje;
    }
}