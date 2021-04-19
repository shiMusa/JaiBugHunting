#import "Basic";


TreeElementType :: enum u8 {
	BRANCH;
	LEAF;
}

TreeElement :: struct (type: TreeElementType) {};


Branch :: struct(L: Type, R: Type) {
	using el: TreeElement(.BRANCH);
	left: L;
	right: R;
}
branch :: inline (left: $L/TreeElement, right: $R/TreeElement) -> Branch(L, R) {
	res : Branch(L, R) = ---;
	res.left = left;
	res.right = right;
	return res;
}

Leaf :: struct(T: Type) {
	using el: TreeElement(.LEAF);
	data: T;
}


branch_of_leaves :: (b: Branch($L, $R)) { // this does not work
	assert(b.left.type == .LEAF && b.right.type == .LEAF);
    print("left: %, right: %\n", b.left, b.right);
}


// this compiles interestingly without specifiying 
// the generic parameters of Branch(L, R):
//
// branch_of_leaves :: (b: Branch) {
//     print("left: %, right: %\n", b.left, b.right);
// }


split :: (x: $T/TreeElement) {
	if x.type == .BRANCH {
		_split_branch(x);
	} else if x.type == .LEAF {
		_split_leaf(x);
	}
}

_split_branch :: (x: $T/TreeElement) {
	print("left ");
	split(x.left);
	print("right ");
	split(x.right);
}
_split_leaf :: (x: $T/TreeElement) {
	print("leaf = %\n", x.data);
}


main :: () {
	a := Leaf(int).{42};
	b := Leaf(int).{12};
	c := Leaf(int).{-3};

	br   := branch(b, c);
	home := branch(a, br);

	print("%\n", home);

	branch_of_leaves(br);

	split(home);
}