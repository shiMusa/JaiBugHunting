#import "Basic";

foo :: ($$check: bool) -> int #dump {
    if check {
        return 0x10;
    } else {
        return 0x01;
    }
}

bar :: ($check : bool) -> int #dump {
    #if check {
        return 0x10;
    } else {
        return 0x01;
    }
}

main :: () {
    t := true;
    foo(t);
    c :: false;
    foo(c);

    bar(c);
    bar(true);
}