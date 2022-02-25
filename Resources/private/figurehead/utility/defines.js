#define PAMPHLET_PREPROCESSOR

#define FOREACH(X,Y) for (let _arr = (Y != undefined ? Y : []), _idx = 0, X = undefined; X = _arr[_idx], _idx < _arr.length; _idx++)
#define FOREACHREV(X,Y) for (let _arr = (Y != undefined ? Y : []), _idx = _arr.length - 1, X = undefined; X = _arr[_idx], _idx >= 0; _idx--)
