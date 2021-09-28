#import "Basic";

Complex :: struct (T: Type) {
    real: T;
    imag: T;
}
cpx :: inline (re: $T = 0.0, im: T = 0.0) -> Complex(T) {
    r: Complex(T) = ---;
    r.real = re;
    r.imag = im;
    return r;
}

operator - :: inline (a: Complex($T)) -> Complex(T) {
    return cpx(-a.real, -a.imag);
}


Quaternion :: struct (T: Type) {
    r: T;
    i: T;
    j: T;
    k: T;
}


// comment this function out and it will compile!
operator + :: inline (a: Quaternion($A), b: Complex($B)) -> Quaternion(A) #symmetric {
    return a;
}


main :: () {
    z := cpx(1.0, 2.0);
    
    p := -z; // remove the '-' and it will compile

    print("%\n", p);
}