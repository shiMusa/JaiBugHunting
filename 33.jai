#import "Basic";

foo :: (x: $T, y: T) -> T {
    return x + y;
}

main :: () {
    z := foo(1.0, 1.0e-12);
    print("%\n", z);
}