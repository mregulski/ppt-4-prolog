% CHECK-ONLY PARSER

program --> [].
program --> instruction, program.

instruction --> [id(X)], [sep(:=)], expression, [sep(;)].
instruction --> [key(read)], [id(X)], [sep(;)].
instruction --> [key(write)], expression, [sep(;)].
instruction --> [key(if)], condition, [key(then)], program, [key(fi)], [sep(;)].
instruction --> [key(if)], condition, [key(then)], program, [key(else)], program, [sep(;)].
instruction --> [key(while)], condition, [key(do)], program, [key(od)], [sep(;)].

expression --> part, [sep(+)], expression.
expression --> part, [sep(-)], expression.
expression --> part.

part --> factor, [sep(*)], part.
part --> factor, [sep(/)], part.
part --> factor, [key(mod)], part.
part --> factor.

factor --> [id(X)].
factor --> [int(X)].
factor --> [sep('(')], expression, [sep(')')].

condition --> conjunction, [key(or)], condition.
condition --> conjunction.

conjunction --> simple, [key(and)], conjunction.
conjunction --> simple.

simple --> expression, [sep(=)], expression.
simple --> expression, [sep(/=)], expression.
simple --> expression, [sep(<)], expression.
simple --> expression, [sep(>)], expression.
simple --> expression, [sep(>=)], expression.
simple --> expression, [sep(=<)], expression.
simple --> [sep('(')], condition, [sep(')')].
