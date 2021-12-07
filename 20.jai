Foo :: struct(T: Type){}
Bar :: struct(T: Type) {
    // f: Foo(T); // this works
    using f: Foo(T); //Error: Redeclaration of variable 'T'.
}

main :: () {
    b: Bar(int);
}