#import "Basic";

Branch :: struct(L: Type, R: Type) {
	left: L;
	right: R;
}
branch :: inline (left: $L, right: $R) -> Branch(L, R) {
	res : Branch(L, R) = ---;
	res.left = left;
	res.right = right;
	return res;
}

Leaf :: struct(T: Type) {
	data: T;
}


branch_of_leaves :: (b: Branch(Leaf($L), Leaf($R))) { // this does not work
    print("left: %, right: %\n", b.left, b.right);
}


// this compiles interestingly without specifiying 
// the generic parameters of Branch(L, R):
//
// branch_of_leaves :: (b: Branch) {
//     print("left: %, right: %\n", b.left, b.right);
// }


main :: () {
	a := Leaf(int).{42};
	b := Leaf(int).{12};
	c := Leaf(int).{-3};

	br   := branch(b, c);
	home := branch(a, br);

	print("%\n", home);

	branch_of_leaves(br);
}