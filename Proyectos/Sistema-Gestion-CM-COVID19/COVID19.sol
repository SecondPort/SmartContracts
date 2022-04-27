// SPDX-License-Identifier: MIT
pragma solidity >0.4.24;
pragma experimental ABIEncoderV2;


contract OMS_COVID19 {

    //direccion de la oms -> owner / dueño del contrato
    address public OMS;

    //contructor del contrato
    constructor() public {
        OMS = msg.sender;
    }
    //mapping para relacionar los centros de salud(direccion/address) con la validez del sistema de gestion
    mapping(address=>bool) public Validacion_CentrosSalud;

    //ejemplo1, 0x4423423gemfvkdnwk342 -> true, tiene permisos y false, no tiene permisos

    //array de direcciones que almacene los contratos de los centros de salud validados
    address[] public direcciones_contratos_salud;

    //eventos
    event NuevoCentroValidado(address);
    event NuevoContrato(address, address);

    //modificador que permita unicamente que la oms ejecute la funcion
        modifier UnicamenteOMS(address _direccion){
        require(_direccion == OMS, "No tienes permiso");
        _;
    }

    //funcion para validar centros de salud que puedan autogestionarse --> Unicamente
    function CentroSalud(address _centroSalud) public UnicamenteOMS(msg.sender){
        //aignacion del estado de validacion del centro de salud
        Validacion_CentrosSalud[_centroSalud] = true;
        //emitir evento
        emit NuevoCentroValidado(_centroSalud);
    }


}