
#import "Basic";



foo :: (a: float) -> float #must {
    return a;
}

foo :: (a: float) {
    // do sth
}


main :: () {
    x := foo(42.0);
    foo(x);
}