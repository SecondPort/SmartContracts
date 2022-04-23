// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma experimental ABIEncoderV2;

contract Funciones{

    //añadir dentro de un array de direcciones la direccion de la persona que llame a la funcnion
    address[] public direcciones;

    function nuevaDireccion()public {
        direcciones.push(msg.sender);
    }

    //calcular el hash de los datos proporcionados como parametro
    bytes32 public hash1;

    function hashing(string memory _datos)public{
        hash1 = keccak256(abi.encodePacked(_datos));
    }

    //declaramos un tipo de dato complejo que es comida
    struct Comida{
        string nombre;
        string ingredientes;
    }

    //vamos a crear el dato complejo comida
    Comida public hamburguesa;

    function Hamburguesas(string memory _ingredientes) public{
        hamburguesa = Comida("hamburguesa",_ingredientes);
    }

    //tipo de dato complejo
    struct alumno{
        string nombre;
        address direccion;
        uint edad;
    }

    bytes32 public hash_Id_alumno;

    //calculamos hash
    function hashIdAlumno(string memory _nombre, address _direccion, uint _edad) private{
        hash_Id_alumno = keccak256(abi.encodePacked(_nombre, _direccion, _edad));
    }

    //guardamos con la funcion publica dentro de una lista los alumnos
    alumno[] public lista;
    mapping (string => bytes32) alumnos;

    function nuevoAlumno(string memory _nombre, uint _edad)public{
        lista.push(alumno(_nombre, msg.sender, _edad));
        hashIdAlumno(_nombre, msg.sender, _edad);
        alumnos[_nombre] = hash_Id_alumno;
    }
}