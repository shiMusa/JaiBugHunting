#import "Basic";


Foo :: struct(x: $T) {
	y : T = x;
}


main :: () {
	x := 2;
	f : Foo(x); // leads to unknown(88E77034) : BaseThreadInitThunk
}