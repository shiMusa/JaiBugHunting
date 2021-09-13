#import "Basic";

Base :: struct(type: Type, dtype: Type, N: int){}

Foo :: struct(_dtype: Type, _N: int){
    using _b: Base(Foo(_dtype, _N),_dtype, _N);
    vals : [_N]_dtype;
}

main :: () {
    // the type of `f` is resolved by the compiler just fine!
    f : Foo(float, 10);
    print("f = %\n", f);

    // but the print function of the type goes into an infinite loop
    T :: Foo(int, 4);
    print("T = %\n", T);
}