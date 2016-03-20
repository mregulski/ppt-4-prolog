% length(List, N+1).
% even_permutation(List, EvenPerm) :-
%   List = even permutation of N elements with N+1st element at odd position;
%   List = odd permutation of N elements with N+1st element at even postion.
% it only works if the list is sorted (or by defining inversions as relative
% to original order)
even_permutation( [], [] ).
even_permutation( List, Perm ) :-
    sort(List, [X|Tail]),
    even_permutation( Tail, Perm1 ),
    insert_odd_pos( X, Perm1, Perm ).

even_permutation( List, Perm ) :-
    sort(List, [X|Tail]),
    odd_permutation( Tail, Perm1 ),
    insert_even_pos( X, Perm1, Perm ).

odd_permutation( List, Perm ) :-
    sort(List, [X|Tail]),
    odd_permutation( Tail, Perm1 ),
    insert_odd_pos( X, Perm1, Perm ).

odd_permutation( List, Perm ) :-
    sort(List, [X|Tail]),
    even_permutation( Tail, Perm1 ),
    insert_even_pos( X, Perm1, Perm ).

insert_odd_pos( X, List, [X|List] ).
insert_odd_pos( X, [A, B|List], [A, B|NewList] ) :-
    insert_odd_pos( X, List, NewList ).

insert_even_pos( X, [A|List], [A,X|List] ).
insert_even_pos( X, [A, B|List], [A, B|NewList] ) :-
    insert_even_pos( X, List, NewList ).
