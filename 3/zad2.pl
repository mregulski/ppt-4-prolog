higher(A, B, A) :-
    A > B.
higher(A,B,B) :-
    A <= B.
    
max([X],X).
max([X | Tail], Max) :-
    max(Tail, Max2),
    higher(Max2, X, Max).

max_sum(List, Sum) :-
    !.
