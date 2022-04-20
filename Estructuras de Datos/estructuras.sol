pragma solidity 0.8.13;

contract Estructuras{

    //cliente de una pagina web de pago

    struct cliente{
        string nombre;
        string email;
        uint telefono;
        uint id;
        uint dni;
        uint credit_number;
        uint secret_number;
    }

    cliente cliente1 = cliente("juan","juan@juan.com", 351345123, 1, 42782958, 123456789, 1234);

    //amazon(cualquier pagina de compra y venta)
    struct productos{
        string nombre;
        uint precio;
    }

    productos producto1 = productos("laptop", 20000);

    //proyecto cooperativo de ings para ayudar en diversas causas
    struct ONG{
        address direccion;
        string nombre;
    }

    ONG ONG1 = ONG(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "ONG1");

    struct causa {
        string nombre;
        string descripcion;
        uint monto;
        uint id;
    }

    causa causa1 = causa("corte de luz", "cortar luz en la casa", 10000, 1);

}