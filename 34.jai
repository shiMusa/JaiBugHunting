#import "Basic";

Base :: struct {
    val: int;
}

Other :: struct {
    x: float;
}

Foo :: struct {
    #as o: Other; // error remains with "using" instead of "#as"
    #as b: Base;  // error remains with "using" instead of "#as"
    z: u8;
}
foo :: (b: *Base) {
    f := cast(*Foo)b;
    print("f = %\n", <<f);
}

Bar :: struct {
    using b: Base;
    using o: Other;
    z: u8;
}
bar :: (b: *Base) {
    f := cast(*Bar)b;
    print("f = %\n", <<f);
}


main :: () {
    f : Foo;
    f.b.val = 42;
    f.o.x = 3.141;
    f.z = 2;

    foo(*f);

    b : Bar;
    b.val = 42;
    b.x = 3.141;
    b.z = 2;

    bar(*b);

    // prints
    // f = {{0}, {2}, 200}     // or similarly wrong
    // f = {{42}, {3.141}, 2}  // this is correct
}