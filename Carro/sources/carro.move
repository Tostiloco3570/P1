/*
/// Module: carro
module carro::carro;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module carro::carro {
    use std::debug::print;
    use std::string::{utf8};

    public fun suma(x:u8){
        // let mut n1= 50u16;
        // let entrada: u16 = x as u16;
        // print(&utf8(b"Suma:"));
        // n1 = n1 + entrada;
        // print(&n1);

        // print(&utf8(b"Resta:"));
        // n1 = n1 - entrada;
        // print(&n1);

        // print(&utf8(b"Multiplicacion:"));
        // n1 = n1 * entrada;
        // print(&n1);

        // print(&utf8(b"Division:"));
        // n1 = n1 / entrada;
        // print(&n1);

        // print(&utf8(b"Modulo:"));
        // n1 = n1 % entrada;
        // print(&n1);

        let vdd: bool = true;
        let fal: bool = false;
        

    }

    #[test]
    public fun testing(){
        suma(5)
    }


}