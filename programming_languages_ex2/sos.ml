[@@@ocaml.warning "-8"];;

type config = Inter of Ast.stm * Ast.state 
 | Final of Ast.state;;

  let stop c = match c with 
    (Inter (_, _)) -> true
    | Final (s) -> false;;

let rec sos c = match c with 
 (Ast.Ass (x, e), s) -> Final (Semantics.update x e s)
 | (Skip, s) -> Final s
 | (Comp (s1, s2), s) ->  if stop (sos (s1, s)) 
        then (let Inter (s1',s') = sos(s1, s) in Inter (Comp(s1', s2), s')) 
        else (let Final s' = sos(s1, s) in Inter (s2, s'))   
 | (* need to fill If statment*)
 | (* need to fill While statment*)

 let rec run_sos c =
    if stop (sos c) 
    then (let Inter (s,s0) = sos c in run_sos (s,s0))
    else sos c;;

(* tests *) 

print_string "x = ";;
print_int (let Final state = run_sos (Ast.test1, Semantics.s0) in state "x");;
print_endline "";;

print_string "x = ";;
print_int (let Final state = run_sos (Ast.test2, Semantics.s0) in state "x");;
print_endline "";;

print_string "x = ";;
print_int (let Final state = run_sos (Ast.test3, Semantics.s0) in state "x");;
print_endline "";;

print_string "x = ";;
print_int (let Final state = run_sos (Ast.test4, Semantics.s1) in state "x");;
print_endline "";;

print_string "y = ";;
print_int (let Final state = run_sos (Ast.test4, Semantics.s1) in state "y");;
print_endline "";;