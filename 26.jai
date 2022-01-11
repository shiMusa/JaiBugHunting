#import "Basic";

A :: struct(T: Type) {
    val: T;
}

special :: ($T: Type) -> T {
    res : T;
    res.val = 13;
    return res;
}

main :: () {
    x :: #run special(A(u8));
}