

Foo :: struct(T: Type) {
    sth: T;
}


Super :: struct (T1: Type, T2: Type) {
    T :: #run super_type(T1, T2);
}

super_type :: inline ($a: Type, $b: Type) -> Type {
    #if a == float64 || b == float64 {
        return float64;
    } else if a == float32 || b == float32 {
        return float32;
    } else if a == s64 || b == s64 {
        return s64;
    } else
        return s32;
}



// foo :: (a: Foo($A), b: Foo($B)) -> Foo(#run super_type(A, B)) { // does not work
foo :: (a: Foo($A), b: Foo($B)) -> Foo(Super(A,B).T) {
    type :: #run super_type(A,B);
    res : Foo(type);
    return res;
}

// bar :: (a: Foo($A), b: Foo($B)) -> #run super_type(A, B) { // does not work
// bar :: (a: Foo($A), b: Foo($B)) -> Super(A, B).T { // compiler crash: unknown(C2C87034) : BaseThreadInitThunk
//     type :: #run super_type(A,B);
//     return cast(type) 0;
// }


main :: () {
    a : Foo(float64);
    b : Foo(s64);
    c := foo(a,b);
}