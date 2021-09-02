#import "Basic";


callback :: (val: $T) {
	print("val : % = %\n", T, val);
}


foo :: ($cb: (val: $T) -> ()) {
	cb(42);
}


main :: () {
	foo(callback);
}