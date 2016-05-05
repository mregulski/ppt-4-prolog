tokens([],[]).
% tokens ::= token, tokens

tokens([X|Xs], [Token|Tokens]) :-
    % format("tokens3 X: ~w~n",[X]),
    atom_string(A,X),
    token(A, Token), !,
    tokens(Xs, Tokens).
% handle "<token><sep><token>"
tokens([X|Xs], [Tok1, Sep, Tok2 | Tokens]) :-
    atom_string(A,X),
    sub_atom(A, Before, Length, After, Sub),
    sep(Sub),
    token(Sub, Sep),
    sub_atom(A, 0, Before, _, T1),
    token(T1, Tok1),
    sub_atom(A, _, After, 0, T2),
    token(T2, Tok2), !,
    tokens(Xs, Tokens).
% handle "<token><sep>"
tokens([X|Xs], [Token, Sep | Tokens]) :-
    % format("tokens1 X: ~w~n",[X]),
    atom_string(A,X),
    sub_atom(A, Before, Length, After, Sub),
    sep(Sub),
    token(Sub, Sep),
    sub_atom(A, After, Before, Length, Main),
    token(Main, Token),
    tokens(Xs, Tokens), !.
% handle "<sep><token>"
tokens([X|Xs], [Sep, Token | Tokens]) :-
    % format("tokens2 X: ~w~n",[X]),
    atom_string(A,X),
    sub_atom(A, 0, Length, After, Sub),
    sep(Sub),
    token(Sub, Sep),
    sub_atom(A, Length, After, 0, Main),
    token(Main, Token), !,
    tokens(Xs, Tokens).


% token definitions. each token can only have one meaning, so cut.

token(X, key(X)) :- key(X),!.

token(X, int(X)) :- atom_number(X,N), integer(N), !.

token(X, sep(X)) :- sep(X),!.

token(X, id(Xquot)) :-
    atom_concat('\'', X, A),
    atom_concat(A, '\'', Xquot),
    id(X),!.

key(X) :- member(X, ['read','write','if','then','else','fi','while','do','od','and','or','mod']), !.
int(X) :- integer(X), !.
sep(X) :- member(X, [';','+','-','*','/','(',')','<','>','=<','>=',':=','=','/=']), !.
id(X) :-
    % format("id X: ~w~n", [X]),
    atom_length(X,L),
    L > 0,
    atom_string(X, S),
    string_upper(S, S),
    string_codes(S, Chs),
    forall(
        member(Ch, Chs),
        char_type(Ch, alpha)
    ), !.
    % \+sub_atom(X,_,_,_,';'), !.

write2([]).
write2([X|Xs]) :-
    write(X), nl,
    write2(Xs).

scanner(Stream, Tokens) :-
    read_string(Stream, _, String),
    split_string(String, " \n", " \n", Parts),
    tokens(Parts, Tokens),
    write2(Tokens).
