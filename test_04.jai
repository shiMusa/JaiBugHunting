#import "Basic";


Foo :: struct(x: $T) {
	y : T = x;
}

// Bar :: struct(x: $T) {}

main :: () {
	x := 2;
	f : Foo(x);
	// print("%\n", f.x);
	// print("%\n", f.y);

	// b : Bar(x);
	// print("%\n", b.x);
}