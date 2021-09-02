Foo :: struct(T: Type, N: int) {
    data: [N]T;
}

bar :: (a: Foo($A, $N), b: Foo($B, $M)) -> Foo($C, N) #modify {
    C = A;
} {
    res : Foo(C, N);
    return res;
}


/*
 Error: This lambda has a #modify for which one of the arguments is not a type. Currently we don't yet handle this; there needs to be an overhaul of how #modify works, that will change many things, before this is finalized. In the meantime we apologize for the inconvenience. (Parameter 'N', type *Type_Info.)

    bar :: (a: Foo($A, $N), b: Foo($B, $M)) -> Foo($C, N) #modify {
*/


main :: () {
    a : Foo(int, 4);
    b : Foo(float, 4);
    c := bar(a,b);
}