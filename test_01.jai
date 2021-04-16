#import "Basic";


Foo :: struct(T: Type) {
	sth: T;
}

Bar :: struct {
	sth: float64;
}

bar :: (a: $A) -> $B #modify {
	if A.type == .FLOAT {
		B = type_info(int);
		return;
	}	
	B = A;
} {
	return cast(B)a;
}


super_type :: ($A: Type_Info) -> Type_Info {
	#if A.index_within_type_table == type_info(float).info.index_within_type_table return type_info(u64).info;
	return <<A;
}

get_type :: (A: *Type_Info) -> *Type_Info {
	if A == type_info(Bar) {
		print("heloooooooooooooooooooooo\n");
	} else if A.type == .FLOAT {
		B := type_info(u64);
		return B;
	} else if A.type == .STRUCT {
		B := type_info(float64);
		return B;
	}
	B := A;
	return B;
}


foo :: (f: Foo($A)) -> Foo($B) #modify {
	// tmp :: super_type(<<A);
	// B = type_info(tmp);

	// if A == type_info(Bar) {
	// 	print("heloooooooooooooooooooooo\n");
	// } else if A.type == .FLOAT {
	// 	B = type_info(u64);
	// 	return;
	// } else if A.type == .STRUCT {
	// 	B = type_info(float64);
	// 	return;
	// }
	// B = A;
	B = get_type(A);
} {
	res : Foo(B) = ---;
	#if B == float64 {
		res.sth = 3.141;
	} else {
		res.sth = cast(B)f.sth;
	}
	return res;
}


main :: () {
	x := bar(cast(float64)1.0);
	y := bar(cast(u8)2);

	print("x: %, y: %\n", type_of(x), type_of(y));

	f : Foo(int) = ---;
	f.sth = 42;
	g : Foo(float) = ---;
	g.sth = 3.141;

	fx := foo(f);
	gx := foo(g);


	print("fx: %, fx.T: %, gx: %, gx.T: %\n", fx, fx.T, gx, gx.T);

	k : Foo(Foo(int)) = ---;
	k.sth = f;
	kx := foo(k);
	print("k = %, k.T = %, k.T.T = %\n", k, k.T, k.T.T);
	print("kx = %, kx.T = %\n", kx, kx.T);

	fb : Foo(Bar) = ---;
	fb.sth = Bar.{3.1418893};
	z := foo(fb);
	print("z = %, z.T = %\n", z, z.T);
}
