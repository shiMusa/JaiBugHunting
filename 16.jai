#import "Basic";

<<<<<<< HEAD
iter :: (arr: *[$N]$T, code: Code) #expand {
    for i: 0..N-1 {
        `it := *(<<arr)[i];
        `it_index := i;
        #insert code;
    }
}

map :: (arr: [$N]$T, fun: (int,T) -> $U) -> [N]U {
    res : [N]U;
    for arr {
        res[it_index] = fun(it_index,it);
    }
    return res;
}
map :: (arr: *[$N]int, fun: (int, int) -> int) {
    for i: 0..N-1 {
        v := (<<arr)[i];
        (<<arr)[i] = fun(i, v);
    }
}

main :: () {
    a : [10]int;
    print("a = %\n",a);
    b := map(a, (i,v) => i);
    print("b = %\n",b);
    map(*a, (i,v) => i*i);
    print("a = %\n",a);
    map(*a, (i,v) => -v);
    print("a = %\n",a);

    iter(*a, #code {
        print("%: % -> ", it_index, <<it);
        <<it += 100;
        print("%\n", <<it);
    });
    print("a = %\n",a);

}