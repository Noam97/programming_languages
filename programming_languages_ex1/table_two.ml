type bool_expr =
|Var of string
|Not of bool_expr
|And of bool_expr * bool_expr
|Or of bool_expr * bool_expr;;


let rec expression_value a b val_a val_b = function
	| Var x -> if x = a then val_a
		else if x = b then val_b
		else failwith ""
	| Not expr -> not (expression_value a b val_a val_b expr)
	| And(expr1, expr2) -> expression_value a b val_a val_b expr1 && expression_value a b val_a val_b expr2
	| Or(expr1, expr2) -> expression_value a b val_a val_b expr1 || expression_value a b val_a val_b expr2
let table_two a b expr =
[(true, true, expression_value a b true true expr);
(true, false, expression_value a b true false expr);
(false, true, expression_value a b false true expr);
(false, false, expression_value a b false false expr)];;
