my_merge([X|Xs],[Y|Ys], [X|T]) :-
    freeze(X, (
		freeze(Y, (
			X =< Y,
			my_merge(Xs, [Y|Ys], T)
			)
		)
    )).

my_merge([X|Xs], [Y|Ys], [Y|T]) :-
    freeze(Y, (
		freeze(X, (
			X >=Y,
			my_merge([X|Xs], Ys, T)     
			)
		)
    )).

my_merge([], [Y|Ys], Out) :-
	freeze([Y|Ys], [Y|Ys] = Out).
	
my_merge([X|Xs], [], Out) :-
	freeze([X|Xs], [X|Xs] = Out).


