:- dynamic(fib/2).
afib(0) --> [].
afib(N) --> a(N), b(F), {fib(N, F)}, !.

a(0) --> [].
a(N) --> [a], a(M), {N is M + 1}.

b(0) --> [].
b(N) --> [b], b(M), {N is M + 1}.

fib(0,0) :- !.
fib(1,1) :- !.
fib(N, F) :-
    N1 is N - 1, fib(N1, F2),
    N2 is N - 2, fib(N2, F3),
    F is F2 + F3,
    asserta((fib(N, F) :- !)).