#import "Basic";


Foo :: struct {}

foo :: (f: *Foo) {
    print("foo\n");
}

// bar : (v: *void) -> () : foo; // Error: Type mismatch between the arguments when comparing two procedures. Type wanted: *void; type given: *Foo.
// bar :: cast((*void) -> ())foo; // Error: Declaration claims to be constant, but uses an expression that is not constant.
bar := foo;  // work just fine

main :: () {}