and(A,B) :- A, B.
or(A,B) :- A; B.
not(A) :- \+A.
xor(A,B) :- (A, \+B) ; (\+A, B).
nand(A,B) :- \+ (A,B).
nor(A,B) :- \+ (A;B).
equal(A,B) :- A =:= B.

table(A, B, E) :-
    findall((A, B, Result), (member(A, [true, fail]), member(B, [true, fail]), (E -> Result = true ; Result = fail)), Results),
    maplist(w_tuple, Results).

w_tuple((A,B,Result)):-
    write(A), write(" "),
    write(B), write(" "),
    writeln(Result).




