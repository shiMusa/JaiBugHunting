#import "Basic";

foo :: (n: int, body: Code) #expand {
    `it :: n;
    #insert body;
}

main :: () {
    foo(4, #code {
        print("%\n", it); 
    });
}