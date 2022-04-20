pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;


contract Mappings{

    //elegir un numero
    mapping(address => uint) public Numero;

    function elegirNumero(uint _numero) public{
        Numero[msg.sender] = _numero;
    }

    function consultarNumero() public view returns(uint){
        return Numero[msg.sender];
    }

    // mapping que relaciona persona con cant de dinero
    mapping(string => uint) public CantDinero;

    function mDinero(string memory _nombre, uint _cantidad) public{
        CantDinero[_nombre] = _cantidad;
    }

    function ConsultarDinero(string memory _nombre) public view returns(uint){
        return CantDinero[_nombre];
    }
    //ejemplo de mapping con un tipo de dato complejo
    struct Persona{
        string nombre;
        uint edad;
    }

    mapping(uint=>Persona) public personas;

    function dni_Persona(uint _numeroDni, string memory _nombre, uint _edad)public{
        personas[_numeroDni] = Persona(_nombre, _edad);
    }

    function VisualizarPerosona(uint _dni) public view returns(Persona memory){
        return personas[_dni];
    }
}