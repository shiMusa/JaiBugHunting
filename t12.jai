#import "Basic";

// for_unroll :: ($from: int, $to: int, body: Code) #expand {
//     #insert -> string {
//         builder: String_Builder;
//         init_string_builder(*builder);
//         defer free_buffers(*builder);
    
//         // append(*builder, "    `it: int;\n");
//         for from..to {
//             append(*builder, "{\n");
//             print_to_builder(*builder, "    `it :: %;\n", it);
//             append(*builder, "    #insert body;\n");
//             append(*builder, "}\n");
//         }
//         return builder_to_string(*builder);
//     }
// }

foo :: ($n: int, body: Code) #expand {
    `it :: n;
    #insert body;
}

main :: () {
    x := 42;
    // for_unroll(0, 10, #code {
    //     print("%, %\n", x, it);
    // });
    // {
    //     it :: 0;
    //     #insert #code print("%, %\n", x, it);
    // }
    // {
    //     it :: 1;
    //     #insert #code print("%, %\n", x, it);
    // }
    // {
    //     it :: 2;
    //     #insert #code print("%, %\n", x, it);
    // }
    {
        foo(3, #code { print("%, %\n", x, it); });
    }
    {
        foo(4, #code { print("%, %\n", x, it); });
    }
}