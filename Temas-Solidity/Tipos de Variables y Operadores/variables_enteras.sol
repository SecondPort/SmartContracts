// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract enteros{

    //variables enteras sin signo
    uint myInt;
    uint myIntinIcializado = 3;
    uint cota = 5000;

    //variables enteras sin signo con un numero especifico de bits
    uint8 myInt8Bit;
    uint64 myInt64Bit = 7000;
    uint16 myInt16Bit;

    //variables enteras con signo
    int myIntSigned;
    int myIntSignedInicializado = -3;
    int myInt2 = 2;

    //variables enteras con signo con un numero especifico de bits
    int8 myInt8BitSigned;
    int72 myInt72BitSigned;
    int240 myInt240BitSigned = 9000;

}