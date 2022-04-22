// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;

//declaraciones previas
contract notas{

    //direccion del profesor
    address public profesor;

    constructor(){
        profesor = msg.sender;
    }

    //mapping para relacionar el hash de la identidad del alumno con su nota del examen
    mapping(bytes32 => uint) notas_alumnos;

    //array de los alumnos que pidan revision de examen
    string[] revisiones;

    //eventos
    event alumno_evaluado(bytes32, uint);
    event evento_revision(string);

    //funcion para evaluar a alumnos
    function Evaluar(string memory _idAlumno, uint _nota)public UnicamenteProfesor(msg.sender){
        bytes32 hashAlumno = keccak256(abi.encodePacked((_idAlumno)));

        //relacion entre el hash de la identificacion del alumno y su nota
        notas_alumnos[hashAlumno] = _nota;

        //emision del evento
        emit alumno_evaluado(hashAlumno, _nota);
    }

    modifier UnicamenteProfesor(address _direccion){
        //requiere que la direccion introducida por el parametro sea igual al owner del contrato
        require(_direccion == profesor,"Solo el profesor puede realizar esta accion");
        _;
    }

    //funcion para ver las notas de un alumno
    function VerNotas(string memory _idAlumno)public view returns(uint){
        bytes32 hashAlumno = keccak256(abi.encodePacked((_idAlumno)));
        return notas_alumnos[hashAlumno];
    }
}