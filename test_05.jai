#import "Basic";

printOffset := 0;

println :: inline (msg: string, args: ..Any) {
	print(msg, ..args);
	print("\n");
}

println :: inline (arg: Any) {
	print("%\n", arg);
}


idCounter := 0;
next_id :: inline () -> int {
	res := idCounter;
	idCounter += 1;
	return res;
}


Node :: struct(T: Type) {
	left : *Node = null;
	right: *Node = null;
	data: T;
	id: int;
}

leaf :: (data: $T) -> Node {
	res : Node(T);
	res.data = data;
	res.id = next_id();
	return res;
}

branch :: (left: *Node, right: *Node) -> Node {
	res : Node;
	res.left = left;
	res.right = right;
	res.id = next_id();
	return res;
}



split :: (node: *Node) {
	if node.left == null && node.right == null {
		print("% = %\n", node.id, node.data);
	} else {
		print("% ", node.id);
		split(node.left);
		print("% ", node.id);
		split(node.right);
	}
}





main :: () {
	a := leaf(cast(int) 42);
	b := leaf(3);
	c := leaf(-16);

	ab := branch(*a, *b);
	abc := branch(*ab, *c);

	println(a);
	print("%\n", a.data);
	println(b);
	println(c);
	println(ab);
	println(abc);

	split(*abc);

	x : Any = 32;
	print("x = %\n", x);
	println("x = %", x);
}