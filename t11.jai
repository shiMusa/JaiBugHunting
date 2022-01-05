#import "Basic";

_if :: ($$condition: bool, body_true: Code, body_false: Code = #code {}) #expand {
    #if is_constant(condition) {
        #if condition {
            #insert body_true;
        } else {
            #insert body_false;
        }
    } else {
        if condition {
            #insert body_true;
        } else {
            #insert body_false;
        }
    }
}

foo :: ($$check: bool) -> int {
    _if(check, #code {
        return 0x01;
    }, #code {
        return 0x00;
    });
}

main :: () {
    t := true;
    print("%\n",foo(t));
    print("%\n",foo(true));

    _if(t, #code{print("bla");});
}