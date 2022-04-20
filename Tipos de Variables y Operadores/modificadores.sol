pragma solidity 0.8.13;
pragma experimental ABIEncoderV2;
contract public_private_internal{

    //modificador public
    uint public public_var = 420;
    string public public_string = "public_string";
    address public owner;

    constructor()public{
        owner = msg.sender;
    }

    //modificador private
    uint private private_var = 420;
    string private private_string = "private_string";
    bool private private_bool = true;

    function test(uint _k)public{
        private_var = _k;
    }

    //modificador internal
    uint internal internal_var = 420;
    bytes32 internal hash = keccak256(abi.encodePacked("hola"));
    address internal direccion = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}