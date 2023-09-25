function memoize(f){
    let cache = {};
    return(...args) =>{
        let param = JSON.stringify(arguments);
        if(param in cache){
            return cache[param]
        }
        else{
            cache[param] = f(...args);
            return cache[param]
        }
    }
}

