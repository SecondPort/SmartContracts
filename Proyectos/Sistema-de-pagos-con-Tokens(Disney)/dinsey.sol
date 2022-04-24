// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.7.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";

contract Disney{

    //------------------- DECLARACIONES INICIALES ---------------------


    //intancia del contrato token
    ERC20Basic private token;

    //direccion de Disney (owner)
    address payable public owner;

    //constructor
    constructor() public {
        token = new ERC20Basic(10000);
        owner = msg.sender;
    }

    //estrcutura de datos para almacenar a los clientes de disney
    struct cliente{
        uint tokens_comprado;
        string [] atracciones_disfrutadas;
    }

    //mappig para el registro de clientes
    mapping(address => cliente) public Clientes;

    //------------------- GESTION DE TOKENS ---------------------

    //funcion para establecer el precio de un token
    function PrecioTokens(uint _numTokens)internal pure returns(uint){
        //conversion de tokens a ether 1-1 ---- 1 token --> 1 ether
        return _numTokens*(1 ether);
    }

    //funcion para comprar tokens en disney
    function CompraTokens(uint _numTokens) public payable{
        //establecer el precio de los tokens
        uint coste = PrecioTokens(_numTokens);
        //comprobar que el coste es menor que el saldo del usuario
        require(msg.value >= coste, "No se puede comprar esa cantidad de tokens");
        //diferencia de lo que el cliente paga
        uint returnValue = msg.value - coste;
        //disney retorna la cantidad de ethers al cliente
        msg.sender.transfer(returnValue);
        //obtencion del numero de tokens disponibles
        uint Balance = balanceOf();
        require(_numTokens <= Balance, "No se puede comprar esa cantidad de tokens");
        //se transfiere los tokens al cliente
        token.transfer(msg.sender, _numTokens);
        //registro de tokens comprados
        Clientes[msg.sender].tokens_comprado = _numTokens;
    }

    //funcion para obtener el numero de tokens disponibles
    function balanceOf()public view returns(uint){
        return token.balanceOf(address(this));
    }

    //visualizacion de los tokens del cliente
    function MisTokens()public view returns(uint){
        return token.balanceOf(msg.sender);
    }

    //funcion para generar mas tokens
    function GeneraTokens(uint _numTokens)public Unicamente(msg.sender){
        token.increaseTotalSuply(_numTokens);
    }

    //modificador para controlar las funciones ejecutables por disney
    modifier Unicamente(address _owner){
        require(msg.sender == _owner, "No tienes permisos para ejecutar esta funcion");
        _;
    }

    //------------------- GESTION DE DISNEY ---------------------

    //eventos
    event disfruta_atraccion(string);
    event nueva_atraccion(string, uint);
    event baja_atraccion(string, string);
    event noExisteAtraccion(string, string);
    event yaExisteAtraccion(string, string);
    event AtraccionActivada(string, string);

    //estructura de la atraccion
    struct atraccion{
        string nombre_atraccion;
        uint precio_atraccion;
        bool estado_atraccion;
    }
    //mapping para relacionar un nombre de una atraccion con una estructura de datos de la atraccion
    mapping(string => atraccion) public MappingAtracciones;

    //almacenar en un array las atracciones
    string[] Atracciones;

    //mapping para relacionar una identidad(cliente) con su historial de atracciones
    mapping(address => string[]) public HistorialAtracciones;

    //crear nuevas atracciones
    function NuevaAtraccion(string memory _nombreAtraccion, uint _precio)public Unicamente(msg.sender){
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion == false, "Ya existe una atraccion con ese nombre y esta desactivada");
        //crear atraccion
        MappingAtracciones[_nombreAtraccion] = atraccion(_nombreAtraccion, _precio, true);
        //almacenar en el array de atracciones los nombres
        Atracciones.push(_nombreAtraccion);
        //eventos
        emit nueva_atraccion(_nombreAtraccion, _precio);
    }

    //dar de bja una atraccion
    function BajaAtraccion(string memory _nombreAtraccion)public Unicamente(msg.sender){
        //verificar si la atraccion existe y si esta activa
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion, "La atraccion no existe o no esta activa");
        if(MappingAtracciones[_nombreAtraccion].estado_atraccion == true){
            //desactivar la atraccion
            MappingAtracciones[_nombreAtraccion].estado_atraccion = false;
            //eventos
            emit baja_atraccion(_nombreAtraccion, "La atraccion ha sido dada de baja");
        }
    }

}