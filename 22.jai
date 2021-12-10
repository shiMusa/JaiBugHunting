#import "Basic";



foo :: () -> []float {
    res := NewArray(2, float, false);
    res[0] = 42.0;
    res[1] = 3.141;
    return res;
}

bar :: () -> [2]float {
    res : [2]float;
    res[0] = 42.0;
    res[1] = 3.141;
    return res;
}

main :: () {
    f := foo();
    b := bar();

    print("f = %\n", f);
    print("b = %\n", b);
}