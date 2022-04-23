// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
pragma abicoder v2;
import "./SafeMath.sol";

//interface de nuestro token
interface IERC20{
    //devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns (uint256);

    //devuelve la canti de tokens para una direccion indicada por parametro
    function balanceOf(address _owner) external view returns (uint256);

    //devuelve la cantidad de tokens que el spender podra gastar en nombre del propietario
    function allowance(address _owner, address _spender) external view returns (uint256);

    //devuelve un valor booleano resultado de la operacion indicada
    function transfer(address recipient, uint256 amount) external returns (bool);

    //devuelve un valor booleano con el resultado de la operacion de gasto
    function approve(address _spender, uint256 _amount) external returns (bool);

    //resultado de la operacion de paso de una cantidad de tokens usando el metodo allowance
    function transferFrom(address _from, address _to, uint256 _amount) external returns (bool);

    //evento que se debe emitir cuando una cant de token pase de un orginen a un destino
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //evento que se emite cuando se establece una asignacion con el metodo allowance
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract ERC20Basic is IERC20{

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    using SafeMath for uint256;

    
}
