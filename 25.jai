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

// In Workspace 2 ("Target Program"):
// Error: The program contains circular dependencies.
// Internal Compiler Error: Strangely, we did not find a cycle, so this is probably due to a compiler bug. To help you work around the problem, we'll now print out what is not compiling:
// 
// Here are items, waiting to compile, that look suspicious because we don't know why they are waiting:
// 
// C:/Felix/Projects/Jai/JaiBugHunting/t12.jai:25,9: Info: (procedure 'main')
// 
//     }
//     main :: () {