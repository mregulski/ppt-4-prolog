sum([],0).
sum([Head|Tail], Sum) :-
    sum(Tail, X),
    Sum is X + Head.

% convienence wrapper
max_sum([], 0) :- !. % if list is empty don't go further
max_sum(List, Sum) :-
    max_sum_(List,0, 0, Sum).

% if max_sum/2 is called, this will be called with Y as 'Sum so far'
% which is the expected outcome.
max_sum_([], _, Y, Y).

% Find maximum section sum of a list [H|T].
% Uses a version of Kadane's algorithm.
max_sum_([H|T], MaxEndHere, MaxSoFar, Sum) :-

    NewMaxEndHere #= max(H, MaxEndHere + H),
    NewMaxSoFar #= max(MaxSoFar, NewMaxEndHere),

    max_sum_(T, NewMaxEndHere, NewMaxSoFar, Sum).
