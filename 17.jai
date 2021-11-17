#import "Basic";

Base :: struct(K: int, T: Type){}

Foo :: struct(_T: Type, N: int) {
    using _b: Base(10, _T);
    data: [10]_T;
}

Bar :: struct(_T: Type) {
    using _b: Base(42, _T);
    value: _T;
}


bar :: (b: *Foo($T, $N)) {
    print("T = %\n", T);
    print("b = %\n", <<b);
}

operator * :: (a: Foo($T, $N), b: Foo($U, N)) -> Foo(T, N) {
    return a;
}

operator * ::(a: Bar($T), b: Bar($U)) -> Bar(T) {
    return a;
}

main :: () {
    f : Foo(int, 3);
    bar(*f);

    b : Foo(float, 3);
    res := f * b;
    bar(*res);

    x : Bar(int);
    y : Bar(u8);
    z := x * y;
}