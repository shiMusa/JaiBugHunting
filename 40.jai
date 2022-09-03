Foo :: struct(num: u8) {
    val: float;
}

// None of these versions work!

//  Error: Operator '&' does not work on this type. (Left type of the attempted binary operation: Type; right type: Type).
bar :: (a: Foo($A), b: Foo($B)) -> Foo(A) #modify {
    test := A & B;
} {
    return a;    
}

//  Error: When trying to evaluate a constant Type, a non-constant declaration was encountered.
// bar :: (a: $A/Foo, b: $B/Foo) -> Foo(A) #modify {
//     test := A.num & B.num;
// } {
//     return a;    
// }

//  Error: Undeclared identifier 'a'.
// bar :: (a: Foo, b: Foo) -> Foo(a.num) #modify {
//     test := a.num & b.num;
// } {
//     return a;    
// }

main :: () {
    x := Foo(42).{1.0};
    y := Foo(13).{3.141};
    z := bar(x,y);
}