
Rectangle :: struct {
    x,y,width,height: float32;
}

rectangle :: (x: $X, y: $Y, width: $W, height: $H) -> Rectangle {
    res : Rectangle = ---;
    res.x      = x;
    res.y      = y;
    res.width  = width;
    res.height = height;
    return res;
}


Foo :: struct {
    using rectangle: Rectangle;
}

bar :: (using f: Foo) {
    r := rectangle(1.0,2.0,3.0,4.0);
}


main :: () {
    f : Foo;
    bar(f);
}