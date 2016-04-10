% available operations
operation(X, Y, V, ' + ') :- V is X + Y.
operation(X, Y, V, ' - ') :- V is X - Y, V > 0.
operation(X, Y, V, ' * ') :- V is X * Y.
% limit results to integers.
operation(X, Y, V, ' / ') :- not(Y = 0), not(Y = 1), M is X mod Y, M = 0, V is X // Y.

% construct an expression tree
% case 0: no operands, no tree
buildTree([], _, _) :- !, fail.
% case 1: X is a leaf, end tree here.
buildTree([X|[]], value(X), X).
% case 2: X has subtrees.
buildTree(Xs, tree(Op, TLeft, TRight), Val) :-
    append(L, R, Xs),
    % neither branch can be empty, so neither can be whole Xs
    L \= Xs, buildTree(L, TLeft, V1),
    R \= Xs, buildTree(R, TRight, V2),
    % evaluate current node.
    operation(V1, V2, Val, Op).

% helper: operation -> string
exprText(Left, Op, Right, Txt) :-
    concat('(', Left, T1),
    concat(T1, Op, T2),
    concat(T2, Right, T3),
    concat(T3,')', Txt).

% convert tree to readable expression string.
treeExpr(value(X), X).  % leaf
treeExpr(tree(Op, TLeft, TRight), Txt) :-
    treeExpr(TLeft, TL),
    treeExpr(TRight, TR),
    exprText(TL, Op, TR, Txt).

% launcher. only List has to be instantiated.
expression(List, Target, Expression) :-
    buildTree(List, Tree, Target),
    treeExpr(Tree, Expression).
