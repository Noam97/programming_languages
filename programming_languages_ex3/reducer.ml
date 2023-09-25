(*
  Reducers (interpreters) for lambda-calculus.
*)

open Utils
open Parser


exception OutOfVariablesError


let possible_variables = List.map (fun x -> char_to_string (char_of_int x)) ((range 97 123) @ (range 65 91))


let fresh_var used_vars : string = 
	if StringSet.is_empty (StringSet.diff (string_set_from_list(possible_variables)) used_vars) 
	then raise (OutOfVariablesError)
	else StringSet.choose (StringSet.diff (string_set_from_list(possible_variables)) used_vars)



(*
  ADD FUNCTIONS BELOW
*)

(*A*)
let rec fv term = match term with
    | Variable s -> StringSet.add s StringSet.empty
    | Abstraction (s, t) -> StringSet.remove s (fv t)
    | Application (t1, t2) -> StringSet.union (fv t1) (fv t2);;

(*B*)
let rec substitute x s term = match term with
    | Variable y -> if x = y then s else term
    | Abstraction (y, t) -> if x = y then term
                            else if not (StringSet.mem y (fv s)) then 
                              Abstraction (y, substitute x s t)
                            else 
                              let z = fresh_var (StringSet.union (fv s) (StringSet.union (fv t) (fv (Variable x)))) in
                              let t0 = substitute y (Variable z) t in
                              Abstraction(z, substitute x s t0)          
    | Application (t1, t2) -> Application (substitute x s t1, substitute x s t2);;
    
(*C*)   
let rec reduce_cbv_rec term = match term with
    | None -> None
    | Some t' -> 
     match t' with
     | Variable s -> None
     | Abstraction (s, t) -> None
     | Application (t1, t2) -> 
      match t1 with
      | Variable s -> let t'' = reduce_cbv_rec (Some t2) in (match t'' with
                                           | None -> None
                                           | Some v -> Some (Application(t1, v)))
      | Abstraction (s, t) -> (match t2 with
                                | Variable u -> Some (substitute s t2 t)
                                | Abstraction(_,_) -> Some (substitute s t2 t)
                                | Application(t3,t4) -> let t'' = reduce_cbv_rec (Some t2) in (match t'' with
                                                                             | None -> None
                                                                             | Some v -> Some (Application(t1, v))))
      | Application (t3, t4) -> let t'' = reduce_cbv_rec (Some t1) in (match t'' with
                                                     | None -> let t''' = reduce_cbv_rec (Some t2) in (match t''' with
                                                                                     | None -> None
                                                                                     | Some y -> Some (Application(t1, y)))
                                                     | Some v -> Some (Application(v, t2)));;

let reduce_cbv t = 
	reduce_cbv_rec (Some t);;

(*D*)
  let rec reduce_cbn_rec t = match t with 
	| None -> None
	| Some t' -> match t' with
		     | Variable x -> None
  	             | Abstraction(s1,t1) -> None
  	             | Application(t1,t2) -> match t1 with
  	             			     | Variable s -> None
  	             			     | Abstraction(s,t) -> Some (substitute s t2 t)
  	             			     | Application(t3,t4) -> let t'' = reduce_cbn_rec (Some t1) in match t'' with
  	             			                                                                   | None -> None
  	             			                                                                   | Some v -> Some (Application(v, t2));;
  
  
  


let reduce_cbn t = reduce_cbn_rec (Some t);;




