// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

contract votacion{

    //direccion del propietario del contrato
    address owner;

    constructor()public{
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

    //Funcion auxiliar que transforma un uint a un string
    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

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

    //los votantes van a poder votar
    function Votar(string memory _candidato)public{
        //hash de la persona que ejecuta la funcion
        bytes32 hashVotante = keccak256(abi.encodePacked(msg.sender));
        //verificar si el votante ya voto
        for(uint i = 0; i < votantes.length; i++){
            require(votantes[i] != hashVotante, "Ya voto");
        }
        //almacenamos el hash del votante dentro del array
        votantes.push(hashVotante);
        //añadimos un voto al candidato
        votos_Candidato[_candidato]++;
    }

    //visualizar los votos de un candidato
    function verVotos(string memory _nombre)public view returns(uint){
        return votos_Candidato[_nombre];
    }

    //ver los votos de cada uno de los candidatos
    function VerResultados()public view returns(string memory){
        //guardamos en un string los candidatos con sus votos
        string memory resultados;

        //recorremos el array de candidatos para actualizar el string rasultados
        for(uint i = 0; i < candidatos.length; i++){
            //actualizamos el string rasultados y añadimos el candidato que ocupa la posicion i del array
            //y su numero de vos
            resultados = string(abi.encodePacked(resultados, "(", candidatos[i], ",", uint2str(verVotos(candidatos[i])), ")"));
        }
        return resultados;
    }

}