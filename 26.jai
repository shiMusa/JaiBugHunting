#import "Basic";

A :: struct(T: Type) {
    val: T;
}

foo :: ($T: Type) -> T {
    res : T;
    res.val = 13;
    return res;
}

main :: () {
    x :: #run foo(A(u8));
}