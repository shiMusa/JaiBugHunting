#import "Basic";


Delay :: struct {
    input: float = 0.0;
    output: float = 0.0;
    index : int = 0;
    mem : []float;
}

update :: (using delay: *Delay) {
    index = (index + 1) % mem.count;
    mem[index] = input;
    recover := (index + 1) % mem.count;
    output = mem[recover];
    input = 0.0;
}

main :: () {
    arr : Delay;
    arr.mem = NewArray(10, float);
    print("%\n", arr);

    for 0..20 {
        arr.input = cast(float)it;
        update(*arr);
        print("%\n", arr);
    }
}