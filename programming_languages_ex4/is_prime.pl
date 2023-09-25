is_prime(2).
is_prime(3).
is_prime(X) :-
    integer(X),
    X > 3,
    X mod 2 =\= 0,
    \+ has_fac(X, 3).

has_fac(N, M) :- N mod M =:= 0.
has_fac(N, M) :- M * M < N, M2 is M + 2, has_fac(N, M2).
