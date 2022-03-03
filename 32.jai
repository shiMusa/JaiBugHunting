#import "Basic";

foo :: ($$args: ..int) #expand {
    print("%\n", is_constant(args));
    print("%\n", is_constant(args.count));
    print("%: %\n", type_of(args), <<type_info(type_of(args)));
}

bar :: (x: int) #expand {
    print("%\n", is_constant(x));
}

main :: () {
    foo(1,2,3);
    x := 42;
    bar(x);
    bar(313);
}