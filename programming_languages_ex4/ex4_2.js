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

