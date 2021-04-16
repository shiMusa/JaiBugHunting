
#import "Basic";


Base :: struct(T: Type) {
	sth: T;
	data: []T;
}

get :: inline (x: Base($T)) {
	print("base: sth = %\n", x.sth);
}

Derived :: struct(T: Type) {
	using b: Base(T);
	other: T;
}

get :: inline (x: Derived($T)) {
	print("derived: other = %\n", x.other);
}





foo :: (x: $X/Base) {
	#if X.T == float64 {
		print("constant type T = %\n", X.T);
	}
	print("type_of x = %, x.T = %, x.sth = %\n", type_of(x), x.T, x.sth);
	get(x);
}


bar :: (x: float64) -> $T/Base #modify {
	T = type_info(Derived(float64));	
} {
	res : Derived(float64) = ---;
	res.sth = x;
	res.other = x*x;
	res.data = NewArray(10, float64);
	return res;
}


ref_test :: (x: *int) -> int {
	return <<x;
}


main :: () {
	{
		b : Base(float64) = ---;
		b.sth = 3.141;
		b.data = NewArray(4, float64);
	
			d : Derived(float64) = ---;
			d.b = b;
		d.other = 42.0;

		foo(b);
		foo(d);
	}

	{
		x := bar(3.0);
		print("%\n", x);
	}
	
	print("%\n", 1 << 0);

	{
		x := 41;
		y := *x;
		<<y = 31;

		k := ref_test(y);
		k = 99;

		print("%, %\n", x, <<y);
	}
}