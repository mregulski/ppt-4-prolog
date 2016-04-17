tokens([],[]).
% tokens ::= token, tokens
tokens([X|Xs], [Token|Tokens]) :-
    atom_string(A,X),
    token(A, Token),
    tokens(Xs, Tokens).

% handle "<token>;"
tokens([X|Xs], [Token, Sep|Tokens]) :-
    atom_string(A,X),
    sub_atom(A, L, 1, 0, S),
    token(S, Sep),
    sub_atom(A, 0, L, 1, S2),
    token(S2, Token),
    tokens(Xs, Tokens).

% token definitions. each token can only have one meaning, hence the cut.

token(X, key(X)) :- key(X),!.

token(X, int(X)) :- atom_number(X,N), integer(N), !.

token(X, sep(X)) :- sep(X),!.

token(X, id(X)) :- id(X),!.

key(X) :- member(X, ['read','write','if','then','else','fi','while','do','od','and','or','mod']), !.
int(X) :- integer(X), !.
sep(X) :- member(X, [';','+','-','*','/','(',')','<','>','=<','>=',':=','=','/=']), !.
id(X) :-
    atom_length(X,L),
    L > 0,
    atom_string(X, S),
    string_upper(S, S),
    \+ sub_atom(X,_,_,_,';'),
    !.


scanner(Stream, Tokens) :-
    read_string(Stream, _, String),
    split_string(String, " \n", " \n", Parts),
    tokens(Parts, Tokens), !,
    write(Tokens).
