// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Comida{
    struct plato{
        string nombre;
        string ingredientes;
        uint tiempo;
    }
    //declarar array dinamico de platos
    plato [] platos;
    //relacionamos con un mapping el nombre del plato con sus ingredientes
    mapping(string => string) ingredientes;

    //funcion que nos permite crear un nuevo plato
    function NuevoPlato(string memory _nombre, string memory _ingrediente, uint _tiempo)internal{
        platos.push(plato(_nombre, _ingrediente, _tiempo));
        ingredientes[_nombre] = _ingrediente;
    }

    function ingredientesFinal(string memory _nombre)internal view returns(string memory){
        return ingredientes[_nombre];
    }

}

contract Sanguche is Comida {

    function sanguche(string memory _ingredientes, uint _tiempo)external{
        NuevoPlato("Sanguche", _ingredientes, _tiempo);
    }
    function verIngredientes() external view returns(string memory){
        return ingredientesFinal("Sanguche");
    }
}