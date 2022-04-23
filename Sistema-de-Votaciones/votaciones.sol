// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;

contract votacion{

    //direccion del propietario del contrato
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    //relacion entre el nombre del candidato y el hash de sus datos persoanles
    mapping(string => bytes32) ID_Candidato;
    //relacion entre el nombre del candidato y el numero de votos
    mapping(string => uint) votos_Candidato;

    //lista de todos los candidatos
    string[] candidatos;
    //lista de los hashes votantes
    bytes32[] votantes;

    //funcion para crear un nuevo candidato
    function NuevoCandidato(string memory _nombre, uint _edad, string memory _id)public {
        //hash de los candidatos
        bytes32 hashCandidato = keccak256(abi.encodePacked(_nombre, _edad, _id));

        //almacenatamiento de los datos del candidato
        ID_Candidato[_nombre] = hashCandidato;

        //almacenamos el nombre
        candidatos.push(_nombre);
    }

    //funcion para visualizar los candidatos existentes
    function verCandidatos()public view returns(string[] memory){
        return candidatos;
    }

}