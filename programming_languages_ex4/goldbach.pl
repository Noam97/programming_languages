goldbach(N, M) :-
    N mod 2 =:= 0,
    goldbach(N, 3, M), !.

goldbach(N, P, [P, Q]) :-
    is_prime(P),
    Q is N - P,
    is_prime(Q), !.

goldbach(N, P, M) :-
    P < N,
    P2 is P + 2,
    goldbach(N, P2, M),!.

is_prime(2).
is_prime(3).
is_prime(P) :-
    integer(P),
    P > 3,
    P mod 2 =\= 0,
    \+ has_fac(P, 3).

has_fac(N, M) :- N mod M =:= 0.
has_fac(N, M) :- M * M < N, L2 is M + 2, has_fac(N, L2).
