// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Arrays{

    //arrays de enteros de longitud fija
    uint256[5] public Enteros = [1,2,3,4];

    //arrays de enteros de 32 bits
    uint32[7] Enteros32;

    //arrays de strings de longitus fija
    string[3] Strings;

    //array dinamico de enteros
    uint256[] public EnterosDinamico;

    struct Persona{
        string nombre;
        uint32 edad;
    }

    //array dinamico de tipo persona
    Persona[] public Personas;

    //agregar personas al array
    function agregarPersona(string memory _nombre, uint32 _edad)public{
        Personas.push(Persona(_nombre, _edad));
    }

    function modificarArray(uint _numero)public{
        EnterosDinamico.push(_numero);
    }

    function arrayEstatico() public{
        Enteros[4] = 56;
        Enteros[2] = 32;
    }

    uint public test = Enteros[2];
}