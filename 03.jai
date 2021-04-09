#import "Basic";


Foo :: struct(T: Type) {
    sth: T;
}

bar :: (a: $A) {
    #if A == Foo { // this doesn't work
    // #if A == Foo(float64) { // this does
        print("yay!\n");
    } else {
        assert(false);
    }
}


main :: () {
    f : Foo(float64);
    bar(f);
}