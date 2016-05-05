% PARSER

parse(Tokens, Program) :-
    phrase(program(Program), Tokens).

program([]) --> [].
program([Instruction|Program]) --> !, instruction(Instruction), program(Program).

% something not quite right with ids?
instruction(assign(X, Expression))  -->
    [id(X)], [sep(:=)], expression(Expression), [sep(;)].
instruction(read(X)) -->
    [key(read)], [id(X)], [sep(;)].
instruction(write(ExpressionQ)) -->
    [key(write)], , expression(Expression), [sep(;)].
instruction(if(Condition, Then)) -->
    [key(if)], condition(Condition), [key(then)], program(Then), [key(fi)], [sep(;)].
instruction(if(Condition, Then, Else)) -->
    [key(if)], condition(Condition), [key(then)], program(Then), [key(else)], program(Else), [sep(;)].
instruction(while(Condition, Do)) -->
    [key(while)], condition(Condition), [key(do)], program(Do), [key(od)], [sep(;)].


expression(Part + Expression) -->
    part(Part), [sep(+)], expression(Expression).
expression(Part - Expression) -->
    part(Part), [sep(-)], expression(Expression).
expression(Part) -->
    part(Part).


part(Factor * Part) -->
    factor(Factor), [sep(*)], part(Part).
part(Factor / Part) -->
    factor(Factor), [sep(/)], part(Part).
part(Factor mod Part) -->
    factor(Factor), [key(mod)], part(Part).
part(Factor) --> factor(Factor).


factor(X) -->
    [id(X)].
factor(int(X)) -->
    [int(X)].
factor((Expression)) -->
    [sep('(')], expression(Expression), [sep(')')].


condition(Conjunction ; Condition) -->
    conjunction(Conjunction), [key(or)], condition(Condition).
condition(Conjunction) -->
    conjunction(Conjunction).


conjunction(Simple , Conjunction) -->
    simple(Simple), [key(and)], conjunction(Conjunction).
conjunction(Simple) --> simple(Simple).


simple(Expr1 =:= Expr2) -->
    expression(Expr1), [sep(=)], expression(Expr2).
simple(Expr1 =\= Expr2) -->
    expression(Expr1), [sep(/=)], expression(Expr2).
simple(Expr1 < Expr2) -->
    expression(Expr1), [sep(<)], expression(Expr2).
simple(Expr1 > Expr2) -->
    expression(Expr1), [sep(>)], expression(Expr2).
simple(Expr1 >= Expr2) -->
    expression(Expr1), [sep(>=)], expression(Expr2).
simple(Expr1 =< Expr2) -->
    expression(Expr1), [sep(=<)], expression(Expr2).
simple((Condition)) --> [sep('(')], condition(Condition), [sep(')')].
