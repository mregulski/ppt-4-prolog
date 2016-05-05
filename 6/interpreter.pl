interpreter(X) :-
    interpreter(X, []).
interpreter([], _).
interpreter([read(ID) | INSTRUKCJE], ASOC) :- !,
	read(N),
	integer(N),
	podstaw(ASOC, ID, N, ASOC1),
	interpreter(INSTRUKCJE, ASOC1).
interpreter([write(W) | INSTRUKCJE], ASOC) :- !,
	value(W, ASOC, WART),
	write(WART), nl,
	interpreter(INSTRUKCJE, ASOC).
interpreter([assign(ID, W) | INSTRUKCJE], ASOC) :- !,
	value(W, ASOC, WAR),
	podstaw(ASOC, ID, WAR, ASOC1),
	interpreter(INSTRUKCJE, ASOC1).
interpreter([if(C, P) | INSTRUKCJE], ASOC) :- !,
	interpreter([if(C, P, []) | INSTRUKCJE], ASOC).
interpreter([if(C, P1, P2) | INSTRUKCJE], ASOC) :- !,
	(   prawda(C, ASOC)
	->  append(P1, INSTRUKCJE, DALEJ)
	;   append(P2, INSTRUKCJE, DALEJ)),
	interpreter(DALEJ, ASOC).
interpreter([while(C, P) | INSTRUKCJE], ASOC) :- !,
	append(P, [while(C, P)], DALEJ),
	interpreter([if(C, DALEJ) | INSTRUKCJE], ASOC).

podstaw([], ID, N, [ID = N]).
podstaw([ID = _ | ASOC], ID, N, [ID = N | ASOC]) :- !.
podstaw([ID1 = W1 | ASOC1], ID, N, [ID1 = W1 | ASOC2]) :-
	podstaw(ASOC1, ID, N, ASOC2).

pobierz([ID = N | _], ID, N) :- !.
pobierz([_ | ASOC], ID, N) :-
	pobierz(ASOC, ID, N).

value(int(N), _, N).
value(id(ID), ASOC, N) :-
	pobierz(ASOC, ID, N).
value(W1+W2, ASOC, N) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N is N1+N2.
value(W1-W2, ASOC, N) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N is N1-N2.
value(W1*W2, ASOC, N) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N is N1*N2.
value(W1/W2, ASOC, N) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N2 =\= 0,
	N is N1 div N2.
value(W1 mod W2, ASOC, N) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N2 =\= 0,
	N is N1 mod N2.

prawda(W1 =:= W2, ASOC) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N1 =:= N2.
prawda(W1 =\= W2, ASOC) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N1 =\= N2.
prawda(W1 < W2, ASOC) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N1 < N2.
prawda(W1 > W2, ASOC) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N1 > N2.
prawda(W1 >= W2, ASOC) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N1 >= N2.
prawda(W1 =< W2, ASOC) :-
	value(W1, ASOC, N1),
	value(W2, ASOC, N2),
	N1 =< N2.
prawda((W1, W2), ASSOC) :-
	prawda(W1, ASSOC),
	prawda(W2, ASSOC).
prawda((W1; W2), ASSOC) :-
	(   prawda(W1, ASSOC),
	    !
	;   prawda(W2, ASSOC)).
