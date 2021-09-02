Foo :: struct(T: Type) {}

bar :: (a: Foo($A), b: Foo($B)) {}
bar :: (a: Foo($A), b: $B) {}

main :: () {
    a : Foo(int);
    b : Foo(int);
    bar(a,b);
}