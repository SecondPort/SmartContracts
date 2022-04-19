// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract funciones_globales{

    //msg.sender
    function getSender() public view returns(address){
        return msg.sender;// retorna la direccion del remitente
    }
    // funcion now
    function getNow() public view returns(uint256){
        return block.timestamp;// retorna la fecha actual
    }


    //coinbase
    function getCoinbase() public view returns(address){
        return block.coinbase;// devuelve la direccion del minero que procesa el bloque
    }

    //block.difficulty
    function getDifficulty() public view returns(uint256){
        return block.difficulty;// devuelve la dificultad del bloque
    }

    //block number
    function getBlockNumber() public view returns(uint256){
        return block.number;// devuelve el numero del bloque
    }

    //msg.sig
    function getSig() public view returns(bytes4){
        return msg.sig;// devuelve el hash de la transaccion
    }

    //tx.gasprice
    function getGasPrice() public view returns(uint256){
        return tx.gasprice;// devuelve el precio del gas
    }
    
}