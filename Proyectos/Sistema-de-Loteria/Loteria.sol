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
    }

    //balance de tokens del contrato
    function TokensDisponibles()public view returns(uint){
        return token.balanceOf(contrato);
    }
}