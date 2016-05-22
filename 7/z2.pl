merge(Xs,Ys, [X|T]) :-
    freeze(Xs, (
		freeze(Ys, (
			Xs = [X|Xss],
			Ys = [Y|_],
			X =< Y,
			merge(Xss, Ys, T)
			)
		)
    )).

merge(Xs, Ys, [Y|T]) :-
    freeze(Ys, (
		freeze(Xs, (
			Xs = [X|_],
			Ys = [Y|Yss],
			X >= Y,
			merge(Xs, Yss, T)     
			)
		)
    )).

merge([], Ys, Out) :-
	freeze(Ys, Ys = Out).
	
merge(Xs, [], Out) :-
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
	
split([],[],[]).


merge_sort([X],[X]).
merge_sort([H|T], Out) :-
	freeze(H, (
		split([H|T], A, B),
		%format("A: ~w~nB: ~w~n",[A,B]),
		merge_sort(A, Aout),
		%format("Aout: ~w~n",[Aout]),
		merge_sort(B, Bout),
		%format("Bout: ~w~n~n",[Bout]),
		merge(Aout,Bout, Out),!
		)
	).

	

	

	
merge2(IN1,IN2,OUT):-
	freeze(IN1,
		(IN1 = [H1|T1]->
			freeze(IN2,
				(IN2 = [H2|T2]->
					(H1<H2 ->
						OUT = [H1|REST],
						merge(T1,IN2,REST)
					; 
						OUT = [H2|REST],
						merge(IN1,T2,REST))
				;
				OUT = IN1))
			;
				OUT = IN2)).