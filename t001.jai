


foo :: (a: $T) -> $B {
    return cast(float64)1.0;
}

main :: () {
    res := foo(42);
}