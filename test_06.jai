#import "Basic";


NodeType :: enum u8 {
	LEAF;
	BRANCH;
}
Node :: struct(type: NodeType) {}

Leaf :: struct(T: Type) {
	using n: Node(.LEAF);
	data: T;
}
leaf :: (data: $T) -> Leaf(T) {
	res: Leaf(T);
	res.data = data;
	return res;
}


Branch :: struct(L: Type, R: Type) {
	using n: Node(.BRANCH);
	left: L;
	right: R;
}
branch :: (left: $L/Node, right: $R/Node) -> Branch(L, R) {
	res : Branch(L, R);
	res.left = left;
	res.right = right;
	return res;
}


eval :: (node: $T/Node) -> int {
	#if node.type == .LEAF {
		return node.data;
	} else {
		return eval(node.left) + eval(node.right);
	}
}



main :: () {
	a := leaf(42);
	b := leaf(3);
	c := leaf(-12);

	ab := branch(a, b);
	ab_c := branch(ab, c);

	print("%\n", ab_c);

	print("%\n", eval(ab_c));
}