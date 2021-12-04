#import "Basic";


MatrixType :: struct(
    data_type: Type
){}

BandMatrix :: struct(_T: Type, N: int, M: int, P: int, Q: int) {
    using _m: MatrixType(_T); 
}

get_raw :: inline (m: BandMatrix($T, $N, $M, $P, $Q), i: int) -> T {
    res : T;
    return res;
}




raw :: inline (m: $M/MatrixType) -> *MatrixRawForExpansion(M) {
    res : MatrixRawForExpansion(M) = ---;
    res.matrix = *m;
    return *res;
}

#scope_file
MatrixRawForExpansion :: struct(T: Type) {
    matrix: *T;
}
#scope_export

for_expansion :: (me: *MatrixRawForExpansion($M), body: Code, flags: For_Flags) #expand {
    m := <<(me.matrix);
    i := 0;
    while i < 3 {
        `it_index := i;
        `it := get_raw(m, i);
        // `it := i; // this works
        i += 1;
    }
}

main :: () {
    bm : BandMatrix(int, 15, 17, 1, 2) = ---;
    for raw(bm) {
    }
}