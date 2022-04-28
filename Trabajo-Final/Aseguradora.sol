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
        //introducimos los datos en la estuctura de los labs
        lab memory _laboratorio = lab(_direccionLab, true);
        //relacionamos la direccion que crea el laboratorio con el contrato de laboratorio
        MappingLabs[msg.sender] = _laboratorio;
        //emit evento de laboratorio creado
        emit LaboratorioCreado(msg.sender, _direccionLab);

    }

}

contract Laboratorio is OperacionesBasicas{

    address public DireccionLab;
    address ContratoAseguradora;
    constructor (address _owner, address _direccionContratosAseguradora) public{
        DireccionLab = _owner;
        ContratoAseguradora = _direccionContratosAseguradora;
    }
}