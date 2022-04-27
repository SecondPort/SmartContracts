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

    //mapping para relacionar una address de un centro de salud con su contrato
    mapping(address=>address) public CentroSalud_Contrato;

    //ejemplo1, 0x4423423gemfvkdnwk342 -> true, tiene permisos y false, no tiene permisos

    //array de direcciones que almacene los contratos de los centros de salud validados
    address[] public direcciones_contratos_salud;

    //array de las dirrecciones que soliciten acceso
    address[] public Solicitudes;

    //eventos
    event SolicitudAcceso(address);
    event NuevoCentroValidado(address);
    event NuevoContrato(address, address);

    //modificador que permita unicamente que la oms ejecute la funcion
        modifier UnicamenteOMS(address _direccion){
        require(_direccion == OMS, "No tienes permiso");
        _;
    }

    //funcion que visualiza las dirreciones que han solicitado acceso
    function VisualizarSocilicitude() public UnicamenteOMS(msg.sender) returns(address[]memory){
        return Solicitudes;
    }

    //funcion para solicitar acceso al sistema de gestion
    function SolictarAcceso() public{
        Solicitudes.push(msg.sender);
        //emision del evento
        emit SolicitudAcceso(msg.sender);
    }

    //funcion para validar centros de salud que puedan autogestionarse --> Unicamente
    function CentrosSalud(address _centroSalud) public UnicamenteOMS(msg.sender){
        //aignacion del estado de validacion del centro de salud
        Validacion_CentrosSalud[_centroSalud] = true;
        //emitir evento
        emit NuevoCentroValidado(_centroSalud);
    }

    //funcion para crear un contrato inteligente de un centro de salud
    function FactoryCentroSalud()public {
        //filtrado para que unicamente los centros de salud validados sean capaces de ejectuar esta funcuion
        require (Validacion_CentrosSalud[msg.sender] == true, "No tienes permiso");
        //generar un smartcontract -> generar su direccion
        address contrato_CentroSalud = address(new CentroSalud(msg.sender));
        //almacenar la dire del smartcontract en el array
        direcciones_contratos_salud.push(contrato_CentroSalud);
        //relacion entre el centro de salud y su contrato
        CentroSalud_Contrato[msg.sender] = contrato_CentroSalud;
        //emitir un evento
        emit NuevoContrato(msg.sender, contrato_CentroSalud);
    }
}


//contrato autogestionable por el centro de salud
contract CentroSalud{

    //direcciones iniciales
    address public DireccionCetroSalud;
    address public DireccionContrato;

    constructor (address _direccion) public{
        DireccionCetroSalud = _direccion;
        DireccionContrato = address(this);
    }


}