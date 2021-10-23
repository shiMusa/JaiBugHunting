Foo :: struct(T: Type, val: (T) -> int){}

Bar :: struct {
    using _f: Foo(int, bar);
    val: int;
}
bar :: (i: int) -> int {
    return 42;
}

main :: () {
    b : Bar;
}