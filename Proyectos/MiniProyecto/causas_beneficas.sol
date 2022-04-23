// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract causasBeneficas{

    //declaraciones de variables
    struct Causa{
        uint Id;
        string name;
        uint precio_objetivo;
        uint cantidad_recaudada;
    }

    uint contador_causas = 0;
    mapping(string => Causa) causas;

    //permite dar de alta una causa
    function nuevaCausa(string memory _nombre, uint _precio_objetivo) public payable{
        contador_causas = contador_causas++;
        /* Causa memory causa = Causa(contador_causas, _nombre, _precio_objetivo, 0); */
        causas[_nombre] = Causa(contador_causas, _nombre, _precio_objetivo, 0);
    }


/*     //Esta funcion nos devuelve true en caso de que podamos donar a una causa
    function objetivoCumplido(string memory _nombre, uint _donar)private view returns(bool){
        bool flag = false;
        if(causas[_nombre].cantidad_recaudada + _donar <= causas[_nombre].precio_objetivo){
            flag = true;
        }
        return flag;
    }
    /Esta funcion permite donar a una causa
    function donar(string memory _nombre, uint _cantidad)public returns(bool){

        bool aceptar_donacion = true;

        if(objetivoCumplido(_nombre, _cantidad)){
            causas[_nombre].cantidad_recaudada = causas[_nombre].cantidad_recaudada + _cantidad;
        }else{
            aceptar_donacion = false;
        }
        return aceptar_donacion;
    }
 */

    function donar(string memory _nombre, uint _cantidad)public returns(bool){
        if(causas[_nombre].cantidad_recaudada + _cantidad > causas[_nombre].precio_objetivo){
            return false;
        }else{
            causas[_nombre].cantidad_recaudada = causas[_nombre].cantidad_recaudada + _cantidad;
            return true;
        }
    }

    //esta funcion nos dice si hemos llegado a la meta de recaudacion
    function comprobar_causa(string memory _nombre) public view returns(uint){
        bool flag = false;
        if(causas[_nombre].cantidad_recaudada >= causas[_nombre].precio_objetivo){
            flag = true;
        }
        return causas[_nombre].cantidad_recaudada;
    }

}