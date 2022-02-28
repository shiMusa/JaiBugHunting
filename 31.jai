#import "Basic";


Foo :: struct {
    val: int;
    Constructor: (*Foo, int) -> () : foo_const;
    Destructor: (*Foo) -> ()       : foo_dest;
}

foo_const :: (f: *Foo, val: int) {
    print("foo_const\n");
    f.val = val;
}
foo_dest :: (f: *Foo) {
    print("foo_dest\n");
}


construct_scoped :: (value: *$T, $args: ..Any) #expand {
    #insert -> string {
        print("constructing code...\n");

        builder: String_Builder;
        print_to_builder(*builder, "%.Constructor(value", T);
        for args {
            print_to_builder(*builder, ", %", it);
        }
        append(*builder, ");");
        res := builder_to_string(*builder);
        
        print("inserting: %\n", res);
        return res;
    };
    // T.Constructor(value, #insert args);
    `defer T.Destructor(value);
}

main :: () {
    f : Foo;
    print("constructing f\n");
    construct_scoped(*f, 42);
    print("end of main\n");
}