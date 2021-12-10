#import "Basic";

is_same_type :: ($A: Type, $B: Type) -> bool {
    return A == B;
}

foo :: (a: $A, b: $B) {
    #assert(is_same_type(A,B));
    assert(is_same_type(A,B));
}

main :: () {
    a : s32 = 42;
    b : s32 = 313;
    foo(a,b);
}