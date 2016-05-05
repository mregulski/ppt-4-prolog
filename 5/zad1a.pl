% key(read)  --> "read".
% key(write) --> "write".
% key(if)    --> "if".
% key(then)  --> "then".
% key(else)  --> "else".
% key(fi)    --> "fi".
% key(while) --> "while".
% key(do)    --> "do".
% key(od)    --> "od".
% key(and)   --> "and".
% key(or)    --> "or".
% key(mod)   --> "mod".
%
% sep(;)  --> ";".
% sep(+)  --> "+".
% sep(-)  --> "-".
% sep(*)  --> "*".
% sep(/)  --> "/".
% sep(()  --> "(".
% sep())  --> ")".
% sep(<)  --> "<".
% sep(>)  --> ">".
% sep(=<) --> "=<".
% sep(>=) --> ">=".
% sep(:=) --> ":=".
% sep(=)  --> "=".
% sep(/=) --> "/=".

tokens --> key, tokens.
tokens --> sep, tokens.
tokens --> int, tokens.
tokens --> id, tokens.
tokens([Key|Toks]) --> key(Key), tokens(Toks).
tokens([Sep|Toks]) --> sep(Sep), tokens(Toks).
% white --> code_types(white, [_|_]).

code_types(Type, [Ch|Chs]) --> [Ch], {code_type(Ch, Type)}, !, code_types(Type, Cs).
code_types(_, []) --> [].


token(key(Token)) --> key(Token).
token(sep(Token)) --> sep(Token).
token(int(Token)) --> int(Token).
token(id(Token))  --> id(Token).

key(X) --> {member(X, ["read","write","if","then","else","fi","while","do","od","and","or","mod"]), !}.
int(X) :- integer(X), !.
sep(X) --> {member(X, [";","+","-","*","/","(",")","<",">","=<",">=",":=","=","/="]), !}.

scanner(Stream, Tokens) :-
    read_string(Stream, _, String),
    write(String), nl,
    string_codes(String, Codes),
    write(Codes), nl,
    phrase(tokens(Tokens), Codes).
