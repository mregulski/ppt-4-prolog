/*merge_(Xs,Ys, [X|T]) :-
    freeze(Xs, (
		freeze(Ys, (
			Xs = [X|Xss],
			Ys = [Y|_],
			X =< Y,
			merge_(Xss, Ys, T)
			)
		)
    )).

merge_(Xs, Ys, [Y|T]) :-
    freeze(Ys, (
		freeze(Xs, (
			Xs = [X|_],
			Ys = [Y|Yss],
			X >= Y,
			merge_(Xs, Yss, T)     
			)
		)
    )).

merge_([], Ys, Out) :-
	freeze(Ys, Ys = Out).
	
merge_(Xs, [], Out) :-
	freeze(Xs, Xs = Out).
*/

merge_([X|Xs],[Y|Ys], [X|T]) :-
    freeze(X, (
		freeze(Y, (
			X =< Y,
			merge_(Xs, [Y|Ys], T)
			)
		)
    )).

merge_([X|Xs], [Y|Ys], [Y|T]) :-
    freeze(Y, (
		freeze(X, (
			X >= Y,
			merge_([X|Xs], Ys, T)     
			)
		)
    )).

merge_([], Ys, Out) :-
	freeze(Ys, Ys = Out).
	
merge_(Xs, [], Out) :-
	freeze(Xs, Xs = Out).

split([X,Y|In], [A|Out1], [B|Out2]) :-
	freeze(X, (
			freeze(Y, (
					X=A,
					Y=B,
					split(In, Out1, Out2)
				)
			)
		)
	).
split([X],[X],[]).
split([],[],[]).	



merge_sort([X],[X]) :- freeze(X,true).
merge_sort([H|T], Out) :-
	freeze(H, (
		split([H|T], A, B),
		%format("A: ~w~nB: ~w~n",[A,B]),
		merge_sort(A, Aout),
		%format("Aout: ~w~n",[Aout]),
		merge_sort(B, Bout),
		%format("Bout: ~w~n~n",[Bout]),
		merge_(Aout,Bout, Out),!
		)
	).
