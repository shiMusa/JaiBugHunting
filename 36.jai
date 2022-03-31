some_macro :: ($proc : () -> ()) #expand {
	inline proc();
}

main :: () {
	x := 0;
	some_macro(() => {x += 1;});
}