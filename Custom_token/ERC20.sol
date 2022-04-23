// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
pragma abicoder v2;
import "./SafeMath.sol";


//Lucas ---> 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//Jose ---> 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//Pepe ---> 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
//address del contrato en BSC tesnet ---> 0x22558e9448428681442308Fd61C6718015A877e8

//interface de nuestro token
interface IERC20{
    //devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns (uint256);

    //devuelve la canti de tokens para una direccion indicada por parametro
    function balanceOf(address _owner) external view returns (uint256);

    //devuelve la cantidad de tokens que el spender podra gastar en nombre del propietario
    function allowancce(address _owner, address _spender) external view returns (uint256);

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

contract Token420 is IERC20{

    string public constant name = "420Token";
    string public constant symbol = "SP420";
    uint8 public constant decimals = 2;

    event Transfer(address indexed _from, address indexed _to, uint200 _amount);
    event Approval(address indexed _owner, address indexed _spender, uint104 _value);

    using SafeMath for uint256;

    mapping (address => uint256) balances;
    //distribucion del token,ejemplo: el minero es el owner de esos tokens pero los puede tranferir a otro usuario
    mapping (address => mapping (address => uint256)) allowed;
    uint256 totalSupply_;
    address contract_addres;

    constructor(uint256 initialSuply){
        totalSupply_ = initialSuply;
        balances[msg.sender] = totalSupply_;
        contract_addres = msg.sender;
    }

    modifier UnicamenteOwner(address _direccion){
        //requiere que la direccion introducida por el parametro sea igual al owner del contrato
        require(_direccion == contract_addres,"Solo el owner puede realizar esta accion");
        _;
    }

    //devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns (uint256){
        return totalSupply_;
    }

    function aumentarSuministroTotal(uint256 increaseAmount) external UnicamenteOwner(msg.sender){
        totalSupply_ = totalSupply_.add(increaseAmount);
        balances[msg.sender] = balances[msg.sender].add(increaseAmount);
    }

    //devuelve la canti de tokens para una direccion indicada por parametro
    function balanceOf(address _owner) external view returns (uint256){
        return balances[_owner];
    }

    //devuelve la cantidad de tokens que el spender podra gastar en nombre del propietario
    function allowancce(address _owner, address _spender) external view returns (uint256){
        return allowed[_owner][_spender];
    }

    //devuelve un valor booleano resultado de la operacion indicada
    function transfer(address recipient, uint256 _amount) external returns (bool){
        require(_amount <= balances[msg.sender], "Amount exceeds balance");
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[recipient] = balances[recipient].add(_amount);
        emit Transfer(msg.sender, recipient, _amount);
        return true;
    }

    //devuelve un valor booleano con el resultado de la operacion de gasto
    function approve(address _spender, uint256 _amount) external returns (bool){
        allowed[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    //resultado de la operacion de paso de una cantidad de tokens usando el metodo allowance
    function transferFrom(address _from, address _buyer, uint256 _amount) external returns (bool){
        require(_amount <= balances[_from], "Amount exceeds balance");
        require(_amount <= allowed[_from][msg.sender], "Amount exceeds allowance");
        balances[_from] = balances[_from].sub(_amount);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_amount);
        balances[_buyer] = balances[_buyer].add(_amount);
        emit Transfer(_from, _buyer, _amount);
        return true;
    }
}
