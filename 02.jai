#import "Basic";

Foo :: struct (T: Type) {
    data: T;
}


// #insert #run () -> string {return "init :: () {}";}();

#insert #run specialize("_init", "init", .[.[]], .[.["int"]]);
_init :: (ret: *int) {}

// #insert #run specialize("_add", "add", 
//     .[
//         .["Foo(float64)", "Foo(float64)"],
//         .["Foo(int)", "Foo(float64)"],
//         .["Foo(float64)", "Foo(int)"],
//         .["Foo(int)", "Foo(int)"],
//     ], .[
//         .["Foo(float64)"],
//         .["Foo(float64)"],
//         .["Foo(float64)"],
//         .["Foo(int)"],
//     ]
// );
#insert #run specialize("_add", "operator +", 
    .[
        .["Foo(float64)", "Foo(float64)"],
        .["Foo(int)", "Foo(float64)"],
        .["Foo(float64)", "Foo(int)"],
        .["Foo(int)", "Foo(int)"],
    ], .[
        .["Foo(float64)"],
        .["Foo(float64)"],
        .["Foo(float64)"],
        .["Foo(int)"],
    ]
);
_add :: (a: Foo($A), b: Foo($B), res: *Foo($C)) {
    res.data = cast(C)a.data + cast(C)b.data;
}


main :: () {
    init();

    a : Foo(float64);
    a.data = 3.141;
    b : Foo(int);
    b.data = 42;

    // c := add(a, b); // this has to be uncommented to work!
    d := a + b;
}




// meant to be used in the form of
//     #insert #run specialize(...);
// generates functions
//     fun_name :: inline (x0: itypes[i][0], x1: itypes[i][1],...) -> otypes[i][0], otypes[i][1],... {...}
// by accessing the generic function
//     _fun_name :: (x0: $A, x1: $B, ..., xn: *$NA, xn+1: *$NB, ...) {...}
// writing specialized versions with return types;
specialize :: (backend_name: string, fun_name: string, itypes: [][]string, otypes: [][]string) -> string {
    assert(itypes.count == otypes.count);

    builder: String_Builder;
    defer free_buffers(*builder);

    for f: 0..itypes.count-1 {
        n := itypes[f].count;

        print_to_builder(*builder, "% :: inline (", fun_name);
        for i: 0..itypes[f].count-1 {
            print_to_builder(*builder, "x%: %", i, itypes[f][i]);
            if i != itypes[f].count-1 {
                append(*builder, ", ");
            }
        }
        append(*builder, ") -> ");
        for i: 0..otypes[f].count-1 {
            print_to_builder(*builder, "%", otypes[f][i]);
            if i != otypes[f].count-1 {
                append(*builder, ", ");
            }
        }
        
        append(*builder, " {\n");


        for i: 0..otypes[f].count-1 {
            print_to_builder(*builder, 
                "    x% : % = ---;\n", i+n, otypes[f][i]
            );
        }


        print_to_builder(*builder, "    %(", backend_name);
        for i: 0..itypes[f].count-1 {
            print_to_builder(*builder, "x%", i);
            if i != itypes[f].count-1 {
                append(*builder, ", ");
            } else if otypes[f].count != 0 {
                append(*builder, ", ");
            }
        }
        for i: 0..otypes[f].count-1 {
            print_to_builder(*builder, "*x%", i+n);
            if i != otypes[f].count-1 {
                append(*builder, ", ");
            }
        }

        append(*builder, ");\n");
        
        append(*builder, "    return ");
        for i: 0..otypes[f].count-1 {
            print_to_builder(*builder, "x%", i+n);
            if i != otypes[f].count-1 {
                append(*builder, ", ");
            }
        }
        append(*builder, ";\n");

        append(*builder, "}\n");
    }

    s := builder_to_string(*builder);
    print("Functions created: \n%\n", s);
    return s;
}