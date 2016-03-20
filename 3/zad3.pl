% length(List, N+1).
% even_permutation(List, EvenPerm) :-
%   List = even permutation of N elements with N+1st element at odd position;
%   List = odd permutation of N elements with N+1st element at even postion.
% it only works if the list is sorted (or by defining inversions as relative
% to original order)

% SORTING: for number lists sortig is neccessary. Otherwise the program treats
% the input list as sorted, and therefore number of inversions depends on the
% ordering. E.g. [1,2,4,3] is odd, but calling even_permutation([1,2,4,3],X)
% returns the same list as first X. This is incorrect if input is treated as
% numbers, but correct if they are treated as ordered atoms.

even_permutation( [], [] ).
even_permutation( [X|Tail], Even ) :-
    %sort(List, [X|Tail]),
    even_permutation( Tail, Odd ),
    insert_odd_pos( X, Odd, Even ).

even_permutation( [X|Tail], Even ) :-
    %sort(List, [X|Tail]),
    odd_permutation( Tail, Odd ),
    insert_even_pos( X, Odd, Even ).

odd_permutation( [X|Tail], Odd ) :-
    %sort(List, [X|Tail]),
    odd_permutation( Tail, Even ),
    insert_odd_pos( X, Even, Odd ).

odd_permutation( [X|Tail], Odd ) :-
    %sort(List, [X|Tail]),
    even_permutation( Tail, Even ),
    insert_even_pos( X, Even, Odd ).

insert_odd_pos( X, List, [X|List] ).
insert_odd_pos( X, [A, B|List], [A, B|NewList] ) :-
    insert_odd_pos( X, List, NewList ).

insert_even_pos( X, [A|List], [A,X|List] ).
insert_even_pos( X, [A, B|List], [A, B|NewList] ) :-
    insert_even_pos( X, List, NewList ).
