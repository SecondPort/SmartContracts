// SPDX-License-Identifier: MIT
pragma solidity >0.4.0;
pragma experimental ABIEncoderV2;
import "../Trabajo-Final/Tools/OperacionesBasicas.sol";
import "../Trabajo-Final/Tools/ERC20.sol";

//contrato para la compañia de seguro
contract InsuranceFactory is OperacionesBasicas{

    constructor() public{
        token = new ERC20Basic(100);
        Insurance = address(this);
        Aseguradora = msg.sender;
    }

    struct cliente{
        address DireccionCliente;
        bool Autorizacion;
        address DireccionContrato;
    }

    struct servicio{
        string nombreServicio;
        uint precioTokens;
        bool EstadoServicio;
    }

    struct lab{
        address direccionContratoLab;
        bool ValidacionLab;
    }
    //intancia del contrato token
    ERC20Basic private token;

    //declaracion de las direcciones
    address Insurance; //direccion del contrato
    address payable public Aseguradora;


    //mapeos y arrayas para clientes, servicios y labs
    mapping(address=>cliente) public MappingClientes;
    mapping(string=>servicio) public MappingServicios;
    mapping(address=>lab) public MappingLabs;

    //arrays para guardar clientes, servicios y laboratorios
    address[] direccionClientes;
    string[] private nomServicio;
    address[] private direccionesLabs;

    function FuncionUnicamenteAsegurados(address _direccioAsegurado)public view{
        //restriccion para que solo se pueda acceder a la funcion si el usuario es asegurado
        require(MappingClientes[_direccioAsegurado].Autorizacion == true, "No esta autorizado para realizar esta operacion");
    }

    //modificadores y restricciones sobres los clientes
    modifier UnicamenteAsegurados(address _direccionAsegurado){
        //restriccion para que solo se pueda acceder a la funcion si el usuario es asegurado
        FuncionUnicamenteAsegurados(_direccionAsegurado);
        _;
    }

    modifier UnicamenteAseguradora(address _direccionAseguradora){
        //solo la aseguradora puede realizar esta accion
        require(Aseguradora == _direccionAseguradora,
        "No esta autorizado para realizar esta operacion solo personal de la aseguradora");
        _;
    }

    modifier UnicamenteAseguradoraYCliente(address _direccionAseguradora, address _direccionCliente){
        //restriccion para que solo el cliente o la aseguradora ejecuten la funcion
        require(Aseguradora == _direccionAseguradora, "No esta autorizado para realizar esta operacion solo clientes");
        FuncionUnicamenteAsegurados(_direccionCliente);
        _;
    }

/*     modifier Asegurado_o_Aseguradora(addres _direccionAsegurado, address _direccionEntrante){
        require((MappingClientes[_direccionEntrante].Autorizacion == true)|| (Aseguradora == _direccionEntrante),
        "No esta autorizado para realizar esta operacion, solo clientes o personal de la aseguradora");
    } */

    //eventos
    event EventoComprado(uint256);
    event EventoServicioProporcionado(address, string[], uint256);
    event LaboratorioCreado(address, address);
    event AseguradoCreado(address, address);
    event BajaAsegurado(address);
    event ServicioCreado(string, uint256);
    event BajaServicio(string);

    function creacionLab()public{
        //introducimos en el array la direccion que crea el laboratorio
        direccionesLabs.push(msg.sender);
        //creamos una instancia del contrato de laboratorio
        address _direccionLab = address(new Laboratorio(msg.sender, Insurance));
        //relacionamos la direccion que crea el laboratorio con el contrato de laboratorio
        MappingLabs[msg.sender] = lab(_direccionLab, true);
        //emit evento de laboratorio creado
        emit LaboratorioCreado(msg.sender, _direccionLab);
    }

    function creacionContratoAsegurado()public {
        //guarda la direccion del asegurado en un array
        direccionClientes.push(msg.sender);
        //generacion de un contrato para el asegurado
        address _direccionAsegurado = address(new InsuranceHealthRecord(msg.sender, token, Insurance, Aseguradora));
        //almacenamiento de la informacion del asegurado en la estrcutura de datos
        MappingClientes[msg.sender] = cliente(msg.sender, true, _direccionAsegurado);
        //emit evento de asegurado creado
        emit AseguradoCreado(msg.sender, _direccionAsegurado);
    }

    //funcion que devuelve el array de las direcciones de los labs
    function getDireccionesLabs()public view UnicamenteAseguradora(msg.sender) returns(address[] memory){
        return direccionesLabs;
    }

    //funcion que devuelve el array de las direcciones de los clientes
    function getDireccionesClientes()public view UnicamenteAseguradora(msg.sender) returns(address[] memory){
        return direccionClientes;
    }

    //funcion para ver el historial de un asegurado
    function consultarHistorialAsegurado(address _direccionAsegurado, address _direccionConsultor)public view
    UnicamenteAseguradoraYCliente(_direccionAsegurado, _direccionConsultor)returns(string memory){
        string memory historial = "";// variable para almacenar el historial
        address direccionContratoAsegurado = MappingClientes[_direccionAsegurado].DireccionContrato;// direccion del contrato del asegurado

        // recorremos el array de servicios
        for(uint i = 0; i < nomServicio.length; i++) {
            // si el servicio esta activo
            if(MappingServicios[nomServicio[i]].EstadoServicio &&
            InsuranceHealthRecord(direccionContratoAsegurado).ServicioEstadoAsegurado(nomServicio[i]) == true){// y el servicio esta activo en el asegurado
                // obtenemos el nombre del servicio y su precio
                (string memory _nomServicio, uint precioServicio) = InsuranceHealthRecord(direccionContratoAsegurado).HistorialCliente(nomServicio[i]);
                // almacenamos y concatenamos el nombre del servicio y su precio al historial
                historial = string(abi.encodePacked(historial, "(", _nomServicio, ",", uint2str(precioServicio), ")-----"));
            }
        }
        return historial;
    }


}

contract InsuranceHealthRecord is OperacionesBasicas{

    enum Estado { ALTA, BAJA }
    struct Owner{
        address direccionPropietario;
        uint saldoPropietario;
        Estado estado;
        IERC20 tokens;
        address insurance;
        address payable aseguradora;

    }

    Owner propietario;

    constructor(address _owner, ERC20Basic _token, address _insurance, address payable _aseguradora) public{
        propietario.direccionPropietario = _owner;
        propietario.saldoPropietario = 0;
        propietario.estado = Estado.ALTA;
        propietario.tokens = _token;
        propietario.insurance = _insurance;
        propietario.aseguradora = _aseguradora;
    }

    struct ServciosSolicitados{
        string nombreServicio;
        uint256 precioServicio;
        bool estadoServicio;
    }

    struct ServiciosSolicitadosLab{
        string nombreServicio;
        uint256 precioServicio;
        address direccionLab;
    }

    mapping(string => ServciosSolicitados)HistorialAsegurado;
    ServiciosSolicitadosLab[] historialAseguradoLaboratorio;

    function HistorialAseguradoLaboratorio() public view returns (ServiciosSolicitadosLab[] memory){
        return historialAseguradoLaboratorio;
    }

    function HistorialCliente(string memory _servicio)public view returns(string memory nombreServico, uint256 precioServicio){
        return (HistorialAsegurado[_servicio].nombreServicio, HistorialAsegurado[_servicio].precioServicio);
    }

    function ServicioEstadoAsegurado(string memory _servicio)public view returns(bool){
        return HistorialAsegurado[_servicio].estadoServicio;
    }
}


contract Laboratorio is OperacionesBasicas{

    //direccion de la persona que creo que laboratorio
    address public DireccionLab;
    //direcion del contrato de la aseguradora
    address contratoAseguradora;
    constructor (address _owner, address _direccionContratosAseguradora) public{
        DireccionLab = _owner;
        contratoAseguradora = _direccionContratosAseguradora;
    }
}