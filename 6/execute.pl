:- include('tokenizer.pl').
:- include('parser.pl').
:- include('interpreter.pl').

write_list([]) :- nl.
write_list([H|T]) :-
    write(H), nl, write_list(T).

execute(File) :-
    open(File, 'read', Stream),
    scanner(Stream, Tokens),
    close(Stream),
    parse(Tokens, Program), !,
    write(Program), nl,
    interpreter(Program).
