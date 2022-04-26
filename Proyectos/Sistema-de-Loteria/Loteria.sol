// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;
import "./SafeMath.sol";
import "./ERC20.sol";

contract loteria{

    //intancia del contrato Token
    ERC20Basic private token;

    //direcciones
    address public owner;
    address public contrato;

    //variable para el numero de tokens a crear
    uint public tokens_creados = 10000;

    //evanto de compra de tokens
    event ComprandoTokens(address,uint);

    constructor()public{
        token = new ERC20Basic(tokens_creados);
        owner = msg.sender;
        //con this hacemos referencia al contrato
        contrato = address(this);
    }

    //---------------------- TOKEN ----------------------------

    //establecer precio al token
    function PrecioTokens(uint _numTokens)internal pure returns(uint){
        return _numTokens*(0.1 ether);
    }

    //generar mas tokens por la loteria
    function GeneraTokens(uint _numTokens)public Unicamente(msg.sender){
        token.increaseTotalSuply(_numTokens);
    }

    //modificador para hacer funciones solamente para el owner del contrato
    modifier Unicamente(address _direccion){
        require(_direccion == owner,"No tienes permisos para realizar esta accion");
        _;
    }

    //comprar tokens
    function CompraTokens(uint _numTokens)public payable{
        //calcular el precio del token
        uint coste = PrecioTokens(_numTokens);
        //se requiere que el valor de ethers pagadoss sea equivalente al coste
        require(msg.value >= coste,"No tienes suficientes ethers para comprar tokens");
        //devolverr la diferiencia entre el valor de ethers pagados y el coste
        msg.sender.transfer(msg.value - coste);
        //obtener el balance de tokens del contrato
        uint balance = TokensDisponibles();
        //filtro para evaluar los tokens a comprar con los tokens disponibles
        require((_numTokens <= balance),"No tienes suficientes tokens para comprar");
        //tranferencia de tokes al comprador
        token.transfer(msg.sender, _numTokens);
        //emitir evento de compra de tokens
        emit ComprandoTokens(msg.sender,_numTokens);
    }

    //balance de tokens del contrato
    function TokensDisponibles()public view returns(uint){
        return token.balanceOf(contrato);
    }

    //balance de tokens acumulados en el bote
    function Bote()public view returns(uint){
        return token.balanceOf(owner);
    }

    //Balance de tokens del usuario
    function MisTokes()public view returns(uint){
        return token.balanceOf(msg.sender);
    }

    //---------------------- LOTERIA ----------------------------

    //precio del boleto en tokens
    uint public PrecioBoleto = 5;
    //relacion entre la persona que compra y los numeros de los boletos
    mapping(address => uint[]) public idPersona_boletos;
    //relacion para identificar el ganador
    mapping(uint => address) public ADN_Boleto;
    //numero aleatorio para el boleto
    uint randNonce = 0;
    //registro de los boletos generados
    uint[] boletos_comprados;
    //eventos
    event boleto_comprado(uint);
    event boleto_ganador(uint);
    event tokens_devueltos(address,uint);

    //funcion para comprar boletos
    function CompraBoleto(uint _boletos)public{
        //precio total de boletos a comprar
        uint precio_total = _boletos*PrecioBoleto;
        //filtrado de los tokens a pagar
        require(MisTokes() >= precio_total,"No tienes suficientes ethers para comprar boletos");
        //tranferencua de tokens al owner -> bote/premio
        /* El cliente paga la atraccion en Tokens:
        ? Ha sido necesario crear una funcion en ERC20.sol llamada transferencia_loteria
        ? debido a que en caso de usar el transfer o transferFrom las direcciones
        ? eran equivocadas,ya que el msg.sender que recibia el metodo TransferFrom
        ? era la direccion del contrato.
         */
        token.transferencia_loteria(msg.sender, owner, precio_total);

        /*
        lo que haces es tomar la marca de tiempo actual, el msg.sender y el nonce
        (un numero que solo se utiliza una vez para que no ejectuemos dos veces la misma funcion
        de hash con los mismos parametros de entrada) en incremento
        Luego utilizamos keccakk256 para convertar estas entradas en un hash aleatorio,
        convertimos ese hash a un uint y luego utilizamos % 10000 para tomar los ultimos 4 digitos
        dando un valor aleatorio entre 0 y 9999.
         */
        for (uint i = 0; i < _boletos; i++){
            uint random = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % 10000;
            randNonce++;
            //almacenar los datos del boleto en la relacion
            idPersona_boletos[msg.sender].push(random);
            //numero de boleto comprado
            boletos_comprados.push(random);
            //asignacion del ADN del boleto a la relacion
            ADN_Boleto[random] = msg.sender;
            //emitir evento de compra de boleto
            emit boleto_comprado(random);
        }
    }

    //visualizar el numero de boletos de una pesona
    function TusBoletos()public view returns(uint[] memory){
        return idPersona_boletos[msg.sender];
    }

    //elegir un ganador de forma aleatoria
    function Ganador()public Unicamente(msg.sender){
        //debe haber boletos comprados para generar un ganador
        require(boletos_comprados.length > 0,"No hay boletos para generar un ganador");
        //declaracion de la longitud del array
        uint longitud = boletos_comprados.length;
        //de forma aleatoria seleccionar un numero de boleto entre 0 - longitud
        uint pos_array = uint(uint(keccak256(abi.encodePacked(block.timestamp))) % longitud);
        //seleccionar el boleto del array
        uint eleccion = boletos_comprados[pos_array];
        //emitir evento de ganador
        emit boleto_ganador(eleccion);
        //recuperar la direccion del ganador
        address direccion_ganador = ADN_Boleto[eleccion];
        //enviar tokens del premio al ganador
        token.transferencia_loteria(msg.sender, direccion_ganador, Bote());
    }

    //devolucion de los tokens
    function DevolverTokens(uint _numTokens)public payable{
        //el numero de tokens a devolver debe ser mayor a 0
        require(_numTokens > 0,"No se pueden devolver 0 tokens");
        //el usuario/cliente debe disponer los tokens que desea devovler
        require(_numTokens <= MisTokes(),"No tienes suficientes tokens para devolver");
        //DEVOLUCION:
        //1. el cliente devuelve los tokens
        //2. la loteria paga los tokens devueltos
        token.transferencia_loteria(msg.sender, address(this), _numTokens);
        msg.sender.transfer(PrecioTokens(_numTokens));
        //evento
        emit tokens_devueltos(msg.sender,_numTokens);
    }


}