


function fibonacci(n){
    //F(0) = 0
    if(n===0){
        return 0;
    }
    //F(1) = F(2) = 1
    else if(n===1 || n===2){
        return 1;
    }
    //if there is no cache, then create it
    if(!fibonacci.cache){
        fibonacci.cache = {};
    }
    //if fibonacci(n) is not calculated, then calculate
    if(!fibonacci.cache[n]){
        // console.log('Calculating result', n);
        fibonacci.cache[n] = fibonacci(n-1) + fibonacci(n-2)
    }
    // else{
    //     console.log('Fetching result', n);
    // }

    return fibonacci.cache[n];
}

// console.log(fibonacci(0))
// console.log(fibonacci(1))
// console.log(fibonacci(2))
// console.log(fibonacci(3))
// console.log(fibonacci(4))
// console.log(fibonacci(8))