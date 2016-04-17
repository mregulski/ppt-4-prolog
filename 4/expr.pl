expr([X], _, Expr, Val2):-
   integer(X),
   append(X,"",Expr),
   Val2 is X.
expr([X|Tail], Val, Expr, Val2) :-
    expr(Tail, Val, Expr1, N),
    \+ N = 0,
    Val2 is X / N,
    append("(", Expr1, Expr2),
    append(Expr2, ")", Expr3),
    append("/", Expr3, Expr4),
    append(X, Expr4, Expr).
expr([X|Tail], Val, Expr, Val2) :-
    expr(Tail, Val, Expr1, N),
    Val2 is X * N,
    append("(", Expr1, Expr2),
    append(Expr2, ")", Expr3),
    append("*", Expr3, Expr4),
    append(X, Expr4, Expr).
expr([X|Tail], Val, Expr, Val2) :-
    expr(Tail, Val, Expr1, N),
    Val2 is X - N,
    append("(", Expr1, Expr2),
    append(Expr2, ")", Expr3),
    append("-", Expr3, Expr4),
    append(X, Expr4, Expr).
expr([X|Tail], Val, Expr, Val2) :-
    expr(Tail, Val, Expr1, N),
    Val2 is X + N,
    append("(", Expr1, Expr2),
    append(Expr2, ")", Expr3),
    append("+", Expr3, Expr4),
    append(X, Expr4, Expr).

expr(X, Val, Expr) :-
    permutation(X,Perm),
    expr(Perm,Val,Expr,N),
    N = Val.
