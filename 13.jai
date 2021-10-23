
Trait :: struct(
    type: Type, 
    data_type: Type, 
    get: (t: type, i: int) -> data_type
) {}
get :: (t: $T/Trait, i: int) -> T.data_type {
    return T.get(t, i);
}

Foo :: struct(_T: Type) {
    using _t: Trait(
        #this, 
        _T,
        foo_get
    );
    data: [10]_T;
}
foo_get :: (f: Foo($T), i: int) -> T {
    return f.data[i];
}

View :: struct(TT: Type) {
    using _t: Trait(
        #this, 
        TT.data_type,
        view_get
    );
    inner: *TT;
}
view_get :: (v: View($T), i: int) -> T.data_type {
    return get(<<v.inner, i + 1);
}

view :: (t: *$T/Trait) -> View(T) {
    res : View(T);
    res.inner = t;
    return res;
}

main :: () {
    f: Foo(float64);
    f.data[1] = 1;
    f.data[2] = 2;
    f.data[3] = 3;
    f.data[4] = 4;

    print("%\n", get(f, 0));

    v := view(*f);
    print("%\n", get(v, 0));

    vv := view(*v);
    print("%\n", get(vv, 0));
}

#import "Basic";