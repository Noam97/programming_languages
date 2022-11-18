type bool_expr =
|Var of string
|Not of bool_expr
|And of bool_expr * bool_expr
|Or of bool_expr * bool_expr;;

let rec expression_value var_val_tuppels = function
	| Var x -> List.assoc x var_val_tuppels
	| Not expr -> not (expression_value var_val_tuppels expr)
	| And(expr1, expr2) -> expression_value var_val_tuppels expr1 && expression_value var_val_tuppels expr2
	|Or(expr1, expr2) -> expression_value var_val_tuppels expr1 || expression_value var_val_tuppels expr2


let rec create_table  var_val_tuppels vars expr =
	match vars with
	| [] -> [(List.rev var_val_tuppels, expression_value var_val_tuppels expr)]
	| h::t ->
		create_table((h, true) :: var_val_tuppels) t expr 
@create_table ((h, false) :: var_val_tuppels) t expr
let table vars expr = create_table [] vars expr;;

