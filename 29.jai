#import "Basic";


// Testing the float32 interpretation of scientific number literals

foo :: (x: float32) {
    print("x = %", x);
}

main :: () {
    foo(4.2e-12);
}