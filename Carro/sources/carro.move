/*
/// Module: carro
module carro::carro;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module carro::carro {
    use std::debug::print;
    use std::string::{utf8};
    const NUM: u8 = 100;

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

        // let vdd: bool = true;
        // let fal: bool = false;
        
        // print(&(vdd && fal));
        // print(&(vdd || fal));
        // print(&(!vdd));
        // print(&(!fal));

        print(&(x == NUM));
        print(&(x != NUM));
        print(&(x > NUM));
        print(&(x < NUM));
        print(&(x >= NUM));
        print(&(x <= NUM));
    }

    #[test]
    public fun testing(){
        suma(100)
    }


}