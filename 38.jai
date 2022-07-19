#import "Basic";

SomeStruct :: struct {}

SomeStruct :: () -> SomeStruct {
    res: SomeStruct;
    return res;
}

main :: () {
    s := SomeStruct();
}