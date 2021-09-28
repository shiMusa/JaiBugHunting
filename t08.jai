#import "Basic";

Foo :: struct {
    value: int;
}
Bar :: struct  {
    value: int;
}
Ugh :: struct {
    using f: Foo;
}

do_sth :: (f: $T/Foo) {
    print("%\n", f.value);
}


main :: () {
    b : Ugh;
    b.value = 42;
    do_sth(b);
}