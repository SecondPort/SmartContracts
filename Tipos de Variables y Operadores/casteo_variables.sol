pragma solidity >=0.4.4 <0.7.0;

contract casteo{

    //ejemplo de casteo de variables

    uint8 entero8 = 1;
    uint64 entero64 = 6000;
    uint entero256 =100000;
    int16 entero16 = 156;
    int120 entero120 = 900000;
    int entero = 5000000;

    //casteo de variables

    uint64 public casteo_1 = uint64(entero8);
    uint64 public casteo_2 = uint64(entero256);
    uint8 public casteo_3 = uint8(entero16);
    int public casteo_4 = int(entero120);
    int public casteo_5 = int(entero256);


    function convertir(uint8 _k)public view returns(uint64){
        return uint64(_k);
    }
}