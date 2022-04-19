pragma solidity 0.8.13;

contract enumeraciones{

    //enumeracion de interrumptor
    enum estado{ON, OFF}

    //variable de tipo enum
    estado state;

    function encender()public{
        state = estado.ON;
    }
    function apagar()public{
        state = estado.OFF;
    }

    function fijarEstado(uint _k)public{
        state = estado(_k); //fijar valor por el indice
    }

    function Estado() public view returns(estado){
        return state;
    }

    //enumeracion de direcciones
    enum direcciones {ARRIBA, ABAJO, IZQUIERDA, DERECHA}

    //variable de tipo enum
    direcciones direccion= direcciones.ARRIBA;

    function arriba()public{
        direccion = direcciones.ARRIBA;
    }

    function abajo()public{
        direccion = direcciones.ABAJO;
    }

    function izquierda()public{
        direccion = direcciones.IZQUIERDA;
    }

    function derecha()public{
        direccion = direcciones.DERECHA;
    }

    function fijarDirecciones(uint _k)public{
        direccion = direcciones(_k);
    }

    function Direcciones() public view returns(direcciones){
        return direccion;
    }
}