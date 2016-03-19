sum([],0).
sum([Head|Tail], Sum) :-
    sum(Tail, X),
    Sum is X + Head.

% convienence wrapper
max_sum([], 0) :- !. % if list is empty don't go further
max_sum(List, Sum) :-
    max_sum_(List,0, 0, Sum).


% will be called with Y as 'sum so far'
max_sum_([], _, Y, Y).

% uses variation of Kadane's algorithm
max_sum_([H|T], MaxEndHere, MaxSoFar, Sum) :-

    NewMaxEndHere #= max(H, MaxEndHere + H),
    NewMaxSoFar #= max(MaxSoFar, NewMaxEndHere),
%    Sum1 #= max(NewMaxSoFar, NewMaxEndHere),

%    write("H: "), write(H), nl,
%    write("MaxEndHere: "), write(MaxEndHere),nl,
%    write("MaxSoFar: "), write(MaxSoFar), nl,
%    write("NewMaxEndHere: "), write(NewMaxEndHere),nl,
%    write("NewMaxSoFar: "), write(NewMaxSoFar), nl,

%    write("Sum1: "), write(Sum), nl,
%    write("-----------"),nl,
    max_sum_(T, NewMaxEndHere, NewMaxSoFar, Sum).
