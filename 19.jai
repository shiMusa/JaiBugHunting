#import "Basic";


MatrixType :: struct(
    data_type: Type
){}

BandMatrix :: struct(_T: Type, N: int, M: int, P: int, Q: int) {
    using _m: MatrixType(_T); 
    ROWS : int : P+Q+1; // ? the BandMatrix is of size ROWS × M
    data: [ROWS*M]_T;
}

get_raw :: inline (m: BandMatrix($T, $N, $M, $P, $Q), i: int) -> T {
    return m.data[i];
}

from_raw_index :: inline (m: BandMatrix($T, $N, $M, $P, $Q), i: int) -> int {
    return 42;
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
    while i < 3 { //n_raw(m) {
        `it_index := from_raw_index(m, i);
        `it := get_raw(m, i);
        i += 1;
    }
}

main :: () {
    bm : BandMatrix(int, 15, 17, 1, 2) = ---;
    for raw(bm) {
    }
}