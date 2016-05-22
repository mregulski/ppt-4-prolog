merge([X|Xs],[Y|Ys], [X|T]) :-
    freeze(X, (
		freeze(Y, (
			X =< Y,
			merge(Xs, [Y|Ys], T)
			)
		)
    )).

merge([X|Xs], [Y|Ys], [Y|T]) :-
    freeze(Y, (
		freeze(X, (
			X >=Y,
			merge([X|Xs], Ys, T)     
			)
		)
    )).

merge([], [Y|Ys], Out) :-
	freeze([Y|Ys], [Y|Ys] = Out).
	
merge([X|Xs], [], Out) :-
	freeze([X|Xs], [X|Xs] = Out).


