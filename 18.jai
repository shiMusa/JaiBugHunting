Base :: struct(T: Type){}

Foo :: struct(_T: Type) {
    using _b: Base(_T);
    val: _T;
}

bar :: (b: Base($T)) { // Error: Internal compiler error: Unresolved polymorphism due to a compiler bug.
// bar :: (b: $B/Base) { // works fine
    // your code here
}


main :: () {
    f : Foo(int);
    bar(f);
}