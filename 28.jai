#import "Basic";
#import "Math";


main :: () {
    x : float = 0.0;
    x = sqrt(x);
    print("%\n", x);
    assert(x == 0.0, "x = %", x);
}