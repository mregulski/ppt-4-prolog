sum([],0).
sum([Head|Tail], Sum) :-
    sum(Tail, X),
    Sum is X + Head.

mean(List, Avg) :-
    sum(List, Sum),
    length(List, Length),
    Length > 0,
    Avg is Sum / Length.

variance_([], _, _,0).
variance_([Head|Tail], Mean, Length, Var) :-
    variance_(Tail, Mean, Length, Var2),
    Var is (Var2 + (((Head - Mean)*(Head - Mean))) / Length).

variance(List, Var) :-
    mean(List, Mean),
    length(List, Length),
    variance_(List, Mean, Length, Var).
