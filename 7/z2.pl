/*my_merge_(Xs,Ys, [X|T]) :-
    freeze(Xs, (
		freeze(Ys, (
			Xs = [X|Xss],
			Ys = [Y|_],
			X =< Y,
			my_merge_(Xss, Ys, T)
			)
		)
    )).

my_merge_(Xs, Ys, [Y|T]) :-
    freeze(Ys, (
		freeze(Xs, (
			Xs = [X|_],
			Ys = [Y|Yss],
			X >= Y,
			my_merge_(Xs, Yss, T)     
			)
		)
    )).

my_merge_([], Ys, Out) :-
	freeze(Ys, Ys = Out).
	
my_merge_(Xs, [], Out) :-
	freeze(Xs, Xs = Out).
*/

my_merge([X|Xs], [Y|Ys], [X|T]) :-
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
			X >= Y,
			my_merge([X|Xs], Ys, T)     
			)
		)
    )).

my_merge([], [Y|Ys], Out) :-
	freeze(Y, [Y|Ys] = Out).
	
my_merge([X|Xs], [], Out) :-
	freeze(X, [X|Xs] = Out).

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
split([X],[X],[]) :- freeze(X,true).
split([],[],[]).	

my_merge_sort([X],[X]) :- write(ms),nl,freeze(X,true).
my_merge_sort(In, Out) :-
	freeze(In, (
		split([H|T], A, B),
		%format("A: ~w~nB: ~w~n",[A,B]),
		my_merge_sort(A, Aout),
		%format("Aout: ~w~n",[Aout]),
		my_merge_sort(B, Bout),
		%format("Bout: ~w~n~n",[Bout]),
		my_merge(Aout,Bout, Out),!
		)
	).
	