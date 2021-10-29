#import "Basic";

foo :: inline ($$x: int) {
    #if is_constant(x) {
        foo_cst(x);
    } else {
        foo_dyn(x);
    }
}

foo_dyn :: (x: int) {
    print("dyn x = %\n", x);
}

foo_cst :: ($x: int) {
    print("cst x = %\n", x);
}

main :: () {
    foo(42);
    a := 313;
    foo(a);
}
