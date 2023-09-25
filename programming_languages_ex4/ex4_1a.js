
function factorial(n){
    if(n===0){
        return 1;
    }
    //if there is no cache, then create it
    if(!factorial.cache){
        factorial.cache = {};
    }
    //if factorial(n) is not calculated, then calculate
    if(!factorial.cache[n]){
        // console.log('Calculating result', n);
        factorial.cache[n] = n * factorial(n-1);
    }

    // else{
    //     console.log('Fetching result', n);
    //
    // }

    //fetch from the cache
    return factorial.cache[n]
}

// console.log(factorial(4))
// console.log(factorial(6))