#import "Basic";


Base :: struct {
    test: bool;
}

Foo :: struct {
    using _b: Base;
    val: int;
}

bar :: (x: $B/Base) {
    if x.test then print("yes\n"); 
    else print("no\n");
}
ugh :: (x: *$B/Base) {
    if x.test then print("yes\n"); 
    else print("no\n");
}

main :: () {
    f : Foo = ---;
    f.test = true;
    f.val = 42;
    fp := *f;
    bar(f);
    ugh(*f);
    bar(fp);
    ugh(fp);
}