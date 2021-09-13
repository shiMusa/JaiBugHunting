#import "Basic";


Foo :: struct {
    value: int;
}

bar :: (f: Foo) {
    // ! cannot mutate f because it's passed as a immutable pointer for structs
    f.value = 313;
}

main :: () {
    f : Foo;
    f.value = 42;

    bar(f);

    print("%\n", f);
}