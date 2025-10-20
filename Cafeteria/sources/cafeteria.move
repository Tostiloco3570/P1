module cafeteria::cafeteria {
    use std::string::{String};
    use std::vector;

    // Estructura para representar una cola
    public struct Queue has store, drop {
        items: vector<String>,
        front: u64,
    }

    // Sistema de colas para alumnos y trabajadores
    public struct QueueSystem has key {
        id: UID,
        alumnos: Queue,
        trabajadores: Queue,
    }

    // Crea una nueva cola vacía
    public fun new_queue(): Queue {
        Queue {
            items: vector::empty<String>(),
            front: 0,
        }
    }

    // Verifica si la cola está vacía
    public fun is_empty(queue: &Queue): bool {
        queue.front >= vector::length(&queue.items)
    }

    // Agrega un elemento al final de la cola
    public fun push(queue: &mut Queue, item: String) {
        vector::push_back(&mut queue.items, item);
    }

    // Obtiene el elemento del frente sin extraerlo
    public fun front(queue: &Queue): String {
        if (is_empty(queue)) {
            return std::string::utf8(b"")
        };
        *vector::borrow(&queue.items, queue.front)
    }

    // Extrae el elemento del frente
    public fun pop(queue: &mut Queue) {
        if (!is_empty(queue)) {
            queue.front = queue.front + 1;
        }
    }

    // Inicializa el sistema de colas
    public fun init_system(ctx: &mut TxContext): QueueSystem {
        QueueSystem {
            id: object::new(ctx),
            alumnos: new_queue(),
            trabajadores: new_queue(),
        }
    }

    // Procesa la llegada de un alumno
    public fun llega_alumno(system: &mut QueueSystem, nombre: String) {
        push(&mut system.alumnos, nombre);
    }

    // Procesa la llegada de un trabajador
    public fun llega_trabajador(system: &mut QueueSystem, nombre: String) {
        push(&mut system.trabajadores, nombre);
    }

    // Atiende al siguiente en la fila (prioridad a trabajadores)
    public fun atiende(system: &mut QueueSystem): String {
        // Prioridad a trabajadores
        if (!is_empty(&system.trabajadores)) {
            let nombre = front(&system.trabajadores);
            pop(&mut system.trabajadores);
            return nombre
        } else if (!is_empty(&system.alumnos)) {
            let nombre = front(&system.alumnos);
            pop(&mut system.alumnos);
            return nombre
        };
        
        std::string::utf8(b"")
    }

    // Función para crear el sistema (entry function)
    entry fun create_system(ctx: &mut TxContext) {
        let system = init_system(ctx);
        transfer::share_object(system);
    }

    // Entry function para agregar alumno
    entry fun add_alumno(system: &mut QueueSystem, nombre: String) {
        llega_alumno(system, nombre);
    }

    // Entry function para agregar trabajador
    entry fun add_trabajador(system: &mut QueueSystem, nombre: String) {
        llega_trabajador(system, nombre);
    }

    // Entry function para atender
    entry fun atender(system: &mut QueueSystem): String {
        atiende(system)
    }

    #[test]
    fun test_queue_system() {
        use sui::test_scenario;
        
        let admin = @0xAD;
        let mut scenario = test_scenario::begin(admin);
        
        {
            let mut system = init_system(test_scenario::ctx(&mut scenario));
            
            // Agregar alumnos
            llega_alumno(&mut system, std::string::utf8(b"Juan"));
            llega_alumno(&mut system, std::string::utf8(b"Maria"));
            
            // Agregar trabajadores
            llega_trabajador(&mut system, std::string::utf8(b"Pedro"));
            
            // Atender (debe atender a Pedro primero - trabajador)
            let atendido1 = atiende(&mut system);
            assert!(atendido1 == std::string::utf8(b"Pedro"), 0);
            
            // Atender (ahora atiende alumnos)
            let atendido2 = atiende(&mut system);
            assert!(atendido2 == std::string::utf8(b"Juan"), 0);
            
            let atendido3 = atiende(&mut system);
            assert!(atendido3 == std::string::utf8(b"Maria"), 0);
            
            transfer::share_object(system);
        };
        
        test_scenario::end(scenario);
    }

    #[test]
    fun test_caso_completo() {
        use sui::test_scenario;
        use std::debug;
        
        let admin = @0xAD;
        let mut scenario = test_scenario::begin(admin);
        
        {
            let mut system = init_system(test_scenario::ctx(&mut scenario));
            
            debug::print(&std::string::utf8(b"=== Caso de Prueba ==="));
            
            // 1. LLEGA ALUMNO luis
            debug::print(&std::string::utf8(b"1. LLEGA ALUMNO luis"));
            llega_alumno(&mut system, std::string::utf8(b"luis"));
            
            // 2. LLEGA TRABAJADOR ana
            debug::print(&std::string::utf8(b"2. LLEGA TRABAJADOR ana"));
            llega_trabajador(&mut system, std::string::utf8(b"ana"));
            
            // 3. LLEGA ALUMNO jorge
            debug::print(&std::string::utf8(b"3. LLEGA ALUMNO jorge"));
            llega_alumno(&mut system, std::string::utf8(b"jorge"));
            
            // 4. ATIENDE
            debug::print(&std::string::utf8(b"4. ATIENDE"));
            let resultado1 = atiende(&mut system);
            debug::print(&resultado1); // Debe imprimir: ana
            assert!(resultado1 == std::string::utf8(b"ana"), 0);
            
            // 5. ATIENDE
            debug::print(&std::string::utf8(b"5. ATIENDE"));
            let resultado2 = atiende(&mut system);
            debug::print(&resultado2); // Debe imprimir: luis
            assert!(resultado2 == std::string::utf8(b"luis"), 0);
            
            // 6. LLEGA TRABAJADOR juan
            debug::print(&std::string::utf8(b"6. LLEGA TRABAJADOR juan"));
            llega_trabajador(&mut system, std::string::utf8(b"juan"));
            
            // 7. ATIENDE
            debug::print(&std::string::utf8(b"7. ATIENDE"));
            let resultado3 = atiende(&mut system);
            debug::print(&resultado3); // Debe imprimir: juan
            assert!(resultado3 == std::string::utf8(b"juan"), 0);
            
            debug::print(&std::string::utf8(b"=== Resultado Esperado ==="));
            debug::print(&std::string::utf8(b"ana"));
            debug::print(&std::string::utf8(b"luis"));
            debug::print(&std::string::utf8(b"juan"));
            
            transfer::share_object(system);
        };
        
        test_scenario::end(scenario);
    }
}