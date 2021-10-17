#import "Basic";

foo :: ($T: Type, $val: ..int) {
    print("%, %\n", T, val);
}

foo :: ($val: ..int) {
    print("%\n", val);
}

main :: () {
    foo(42); // Error: Procedure call matches multiple possible overloads:
}