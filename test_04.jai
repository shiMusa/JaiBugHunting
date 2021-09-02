#import "Basic";


Bar :: struct(T: Type) {
	value: T;
}

main :: () {
	b : Bar(int);
	print("%\n", type_of(b));
	print("%\n", <<type_info(type_of(b)));
	assert(type_of(b) == Bar(int));
	assert(b.T == int);
	// assert(type_of(b) == Bar);
}