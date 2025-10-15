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

        // print(&(x == NUM));
        // print(&(x != NUM));
        // print(&(x > NUM));
        // print(&(x < NUM));
        // print(&(x >= NUM));
        // print(&(x <= NUM));

        // if(x == NUM){
        //     print(&utf8(b"Número 100"));
        // }else if (x < NUM){
        //     print(&utf8(b"Número menor a 100"));
        // }else{
        //     print(&utf8(b"Número mayor a 100"));
        // };
        // print(&utf8(b"If terminado"));

        let mut contador: u8 = 0;
        // while(contador < x){
        //     print(&contador);
        //     contador = contador + 1;
        // };
        // print(&utf8(b"While terminado"));
        loop{
            contador = contador + 1;
            if (contador == x){
                break;
            }else if (contador % 2 == 0){
                print(&utf8(b"Numero par"));
                print(&contador);
                continue;
            };
            print(&utf8(b"Numero impar"));
            print(&contador);
        }
    }

    #[test]
    public fun testing(){
        suma(150)
    }


}