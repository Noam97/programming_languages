function memoize(f){
    return function memoized_func(n){
        if(!memoized_func.cache){
            memoized_func.cache = {};
        }
        if(!memoized_func.cache[n]){
            // console.log('Calculating result', n);
            memoized_func.cache[n] = f(n);
        }
        // else{
        //     console.log('Fetching result', n);
        // }
        return memoized_func.cache[n];
    };
}


const fibonacci = memoize(
    (n) => {
        if(n==0){
            return 0;
        }else if (n==1 || n==2){
            return 1;
        }
        else {
            return fibonacci(n - 2) + fibonacci(n - 1)
        }
    }
)
// const memo_fib = memoize(fibonacci);
// console.log(memo_fib(3))
// console.log(memo_fib(4))
// console.log(memo_fib(7))



