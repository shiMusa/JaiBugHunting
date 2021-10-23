Foo :: struct(
    type: Type,
    foo: (x: type) -> int
) {}
foo :: inline (f: $F/Foo) -> int {
    return F.foo(f);
}
foo :: inline (f: *$F/Foo) -> int {
    return F.foo(<<f) + 10;
}

Bar :: struct {
    using _f: Foo(#this, bar_foo);
}
bar_foo :: (b: Bar) -> int {
    return 10;
}

// for_expansion :: (f: *$F/Foo, body: Code, flags: For_Flags) #expand {
//     i := 0;
//     while i < foo(f) {
//         `it_index := i;
//         `it := 42;
//         #insert body;
//         i += 1;
//     }
// }

main :: () {
    b: Bar;
    print("%\n", foo(b));
    print("%\n", foo(*b));
    // for b {
    //     print("for %\n", it_index);
    // }
}

#import "Basic";
