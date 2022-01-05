#import "Basic";

foo :: (x: *int, proc: (*int, int) -> ()) {
    proc(x, 42);
}


main :: () {
    x := 10;
    foo(*x, (n, in) => {
        <<n += in;
    });
    print("%\n", x);
}