board(Queens) :- board(Queens, 5).

board(Queens, ScaleX) :-
	ScaleY is ScaleX // 2+1,
	length(Queens, Size),
	Width is Size * ScaleX-1,
	Height is Size * ScaleY-1,
	forall(
		between(0, Height, RowNum),
		row(Size, RowNum, Width, ScaleX, ScaleY, Queens)
	),
	!.

row(Size, Num, Width, ScaleX, ScaleY, Queens) :-
	forall(
		between(0, Width, ColNum),
		draw_point(Size, ColNum, Num, ScaleX, ScaleY, Queens)
		),
	nl.


% squares
draw_point(Size, Col, Row, ScaleX, ScaleY, Queens) :-
	row_number(Size, Row, ScaleY, RowN),
	col_number(Size, Col, ScaleX, ColN),
	nth1(ColN, Queens, RowN),
	% format('~w, ~w~n',[RowN,ColN]),
	R is RowN mod 2,
	C is ColN mod 2,
	R = C,
	write("\e[0;40m#\e[0m"), !.

draw_point(Size, Col, Row, ScaleX, ScaleY, Queens) :-
	row_number(Size, Row, ScaleY, RowN),
	col_number(Size, Col, ScaleX, ColN),
	nth1(ColN, Queens, RowN),
	square_id(Size, RowN, ColN, Id),
	write("\e[0;30;47m#\e[0m"), !.

draw_point(Size, Col, Row, ScaleX, ScaleY, _) :-
	row_number(Size, Row, ScaleY, RowN),
	col_number(Size, Col, ScaleX, ColN),
	% format('~w, ~w~n',[RowN,ColN]),
	R is RowN mod 2,
	C is ColN mod 2,
	R = C,
	write("\e[0;40m \e[0m"), !.

draw_point(Size, Col, Row, ScaleX, ScaleY,_) :-
	row_number(Size, Row, ScaleY, RowN),
	col_number(Size, Col, ScaleX, ColN),
	square_id(Size, RowN, ColN, Id),
	write("\e[0;47m \e[0m"), !.


% row_number(+Size, +PosY, +ScaleY, ?Number)
row_number(Size, PosY, ScaleY, Number) :-
	% subtract from Size to start counting at the bottom of the board
	Number is Size - PosY // ScaleY.

% col_number(+Size, +PosX, +ScaleX, ?Number)
col_number(_, PosX, ScaleX, Number) :-
	Number is PosX // ScaleX + 1.

%square_id(+Size, +Row, +Col, ?Id)
square_id(Size, Row, Col, Id) :-
	Id is Size * Row + Col - Size.







%
% hetmany - z wykładu
%
permutation([], []).
permutation(L1, [X | L3]) :-
	select(X, L1, L2),
	permutation(L2, L3).

good(X) :-
	\+ bad(X).

bad(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K+1.

hetmany(N, P) :-
	numlist(1, N, L),
	permutation(L, P),
	good(P).
%
%	END hetmany
%
