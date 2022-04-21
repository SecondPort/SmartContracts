pragma solidity 0.8.13;

contract view_pure_payable{

    //view
    string[] lista_alumnos;

    function nuevo_alumno(string memory _nombre) public {
        lista_alumnos.push(_nombre);
    }

    function ver_alumno(uint _pos)public view returns (string memory){
        return lista_alumnos[_pos];
    }

    uint x = 10;
    function sumarAx(uint _x) public view returns (uint){
        return _x + x;
    }

    //pure
    function exponenciacion(uint _a, uint _b)public pure returns (uint){
        return _a ** _b;
    }

    //payable

    //mapping que nos relacione la direccion de la persona que ejecute la funcion de ver saldo(relaciona la direccion con el saldo)
    mapping(address => Cartera) DineroCartera;
    struct Cartera{
        string nombre;
        address propietario;
        uint dinero;
    }

    function Pagar(string memory _nombre, uint _cant) public payable{
        Cartera memory nueva_cartera;
        nueva_cartera = Cartera(_nombre, msg.sender, _cant);
        DineroCartera[msg.sender] = nueva_cartera;
    }

    function verSaldo() public view returns (Cartera memory){
        return DineroCartera[msg.sender];
    }
}