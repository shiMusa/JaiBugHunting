#import "Basic";


Foo :: struct(T: Type) {
	sth: T;
}


bar :: (f: Foo($T)) {
	print("is a Foo(%): sth = %\n", T, f.sth);
}

bar :: (n: $T) #modify {
	// This modify prevents collisions where T == Foo(...)
	using Type_Info_Tag;
	if T.type == INTEGER return;
	if T.type == FLOAT return;
	if T.type == BOOL return;
	if T.type == ENUM return;
	T = null;
} {
	print("is a %, n = %\n", T, n);
}


main :: () {
	f : Foo(float64) = ---;
	f.sth = 42.0;

	bar(f);
	bar(3.141);
}
