// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
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
        string[] atracciones_disfrutadas;
    }

    //mappig para el registro de clientes
    mapping(address => cliente) public Clientes;

    //------------------- GESTION DE TOKENS ---------------------

    //funcion para establecer el precio de un token
    function PrecioTokens(uint _numTokens)internal pure returns(uint){
        //conversion de tokens a ether 1-1 ---- 1 token --> 1 ether
        return _numTokens+(1 ether);
    }

    //funcion para comprar tokens en disney
    function CompraTokens(uint _numTokens) public payable{
        //establecer el precio de los tokens
        uint coste = PrecioTokens(_numTokens);
        //comprobar que el coste es menor que el saldo del usuario
        require(msg.value >= coste, "No tienes suficiente dinero");
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
    event disfruta_atraccion(string, uint, address);
    event nueva_atraccion(string, uint);
    event baja_atraccion(string, string);
    event nueva_comida(string, uint, string);
    event baja_comida(string, string);
    event disfruta_comida(string, string);

    //estructura de la atraccion
    struct atraccion{
        string nombre_atraccion;
        uint precio_atraccion;
        bool estado_atraccion;
    }
    //structura de la comida
    struct comida{
        string nombre_comida;
        uint precio_comida;
        bool estado_comida;
    }
    //mapping para relacionar un nombre de una atraccion con una estructura de datos de la atraccion
    mapping(string => atraccion) public MappingAtracciones;

    //mapping para relacionar un nombre de una comida con una estructura de datos de la comida
    mapping(string => comida) public MappingComidas;

    //almacenar en un array las atracciones
    string[] Atracciones;

    //almacenar en un array las comidas
    string[] Comidas;

    //mapping para relacionar una identidad(cliente) con su historial de atracciones
    mapping(address => string[]) public HistorialAtracciones;

    //maping para relacionar una identidad(cliente) con su historial de comidas
    mapping(address => string[]) public HistorialComidas;

    //crear nuevas atracciones
    function NuevaAtraccion(string memory _nombreAtraccion, uint _precio)public Unicamente(msg.sender){
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion == false,
                                    "Ya existe una atraccion con ese nombre");
        //crear atraccion
        MappingAtracciones[_nombreAtraccion] = atraccion(_nombreAtraccion, _precio, true);
        //almacenar en el array de atracciones los nombres
        Atracciones.push(_nombreAtraccion);
        //eventos
        emit nueva_atraccion(_nombreAtraccion, _precio);
    }

    //crear nueva atraccion
    function NuevaComida(string memory _nombreComida, uint _precio)public Unicamete(msg.sender){
        require(MappingComidas[_nombreComida].estado_comida == false,
                                "Ya existe una comida con ese nombre");
        //crear comida
        MappingComidas[_nombreComida] = comida(_nombreComida, _precio, true);
        //almacenar en el array de comidas los nombres
        Comidas.push(_nombreComida);
        //eventos
        emit nueva_comida(_nombreComida, _precio, "Se creo una nueva comida");
    }

    //dar de bja una atraccion
    function BajaAtraccion(string memory _nombreAtraccion)public Unicamente(msg.sender){
        //verificar si la atraccion existe y si esta activa
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion,
                            "La atraccion no existe o no esta activa");
        if(MappingAtracciones[_nombreAtraccion].estado_atraccion == true){
            //desactivar la atraccion
            MappingAtracciones[_nombreAtraccion].estado_atraccion = false;
            //eventos
            emit baja_atraccion(_nombreAtraccion,
                                        "La atraccion ha sido dada de baja");
        }
    }

    function BajaComida(string memory _nombreComida)public Unicamente(msg.sender){
        require(MappingComidas[_nombreComida].estado_comida,
                            "La comida no existe o no esta activa");
        if(MappingComidas[_nombreComida].estado_comida == true){
            //desactivar la comida
            MappingComidas[_nombreComida].estado_comida = false;
            //eventos
            emit baja_comida(_nombreComida,
                                "La comida ha sido dada de baja");
        }
    }

    //visualizar las atracciones de disney
    function AtraccionesDisponibles()public view returns(string[] memory){
        return Atracciones;
    }

    //visualizar las comidas de disney
    function ComidasDisponibles()public view returns(string[] memory){
        return Comidas;
    }

    //funcion para subirse a una atraccion de disney y pagar en tokens
    function SubirseAtraccion(string memory _nombreAtraccion)public{
        //precio de la atraccion en tokens
        uint tokens_atraccion = MappingAtracciones[_nombreAtraccion].precio_atraccion;
        //verifica el estado de la atraccion(si esta disponible)
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion == true,
                                        "La atraccion no esta disponible");
        //verifica que el cliente tenga tokens suficientes
        require(token.balanceOf(msg.sender) >= tokens_atraccion,
                                "No tienes suficientes tokens");

        /* El cliente paga la atraccion en Tokens:
        ? Ha sido necesario crear una funcion en ERC20.sol llamada tranferencia_disney
        ? debido a que en caso de usar el transfer o transferFrom las direcciones
        ? eran equivocadas,ya que el msg.sender que recibia el metodo TransferFrom
        ? era la direccion del contrato.
         */
        token.transferencia_disney(msg.sender, address(this), tokens_atraccion);
        //actualizar el historial del cliente
        HistorialAtracciones[msg.sender].push(_nombreAtraccion);
        //evento para disfrutar de la atraccion
        emit disfruta_atraccion(_nombreAtraccion, tokens_atraccion, msg.sender);
    }

    function ComprarComida(string memory _nombreComida)public{
        //precio de la comida (en tokens)
        uint tokens_comida = MappingComidas[_nombreComida].precio_comida;
        //verifica el estado de la comida(si esta disponible)
        require(MappingComidas[_nombreComida].estado_comida == true,
                                        "La comida no esta disponible");
        /* El cliente paga la atraccion en Tokens:
        ? Ha sido necesario crear una funcion en ERC20.sol llamada tranferencia_disney
        ? debido a que en caso de usar el transfer o transferFrom las direcciones
        ? eran equivocadas,ya que el msg.sender que recibia el metodo TransferFrom
        ? era la direccion del contrato.
         */
        token.transferencia_disney(msg.sender, address(this), tokens_comida);
        //almacenar en el historial de comidas del cliente
        HistorialComidas[msg.sender].push(_nombreComida);
        //evento para disfrutar de la comida
        emit disfruta_comida(_nombreComida, tokens_comida, msg.sender);
    }

    //funcion para que el cliente visualice su historial de atracciones
    function MisAtracciones()public view returns(string[] memory){
        return HistorialAtracciones[msg.sender];
    }

    function MisComidas()public view returns(string[] memory){
        return HistorialComidas[msg.sender];
    }

    //funcion para que un cliente de disney pueda devolver tokens en cualquier momento
    function DevolverTokens(uint _numTokens)public payable{
        //verificar que el numero de tokens a devolver es positivo
        require(_nomTokens > 0, "No puedes devolver 0 o menos tokens");
        //el usuario debe tener el numero ed tokens que desea devolver
        require(token.balanceOf(msg.sender) >= _numTokens,
                                "No tienes suficientes tokens");
        //el cliente devuelve los tokens
        token.transfer(msg.sender, address(this), _numTokens);
        //devolucion de los ethers al cliente
        msg.sender.transfer(PrecioTokens(_numTokens));
    }

}