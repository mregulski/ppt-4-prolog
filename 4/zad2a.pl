exists(A,Houses) :- select(A, Houses, _).

middle(A,[_,_,A,_,_]).
first(A, [A|_]).

left_of(A,B,Hs) :-
    append(_,[B,A|_],Hs).
next_to(A,B,Hs) :- left_of(A,B,Hs).
next_to(A,B,Hs) :- left_of(B,A,Hs).

print_list([]).
print_list([X|Tail]) :-
    write(X),nl,
    print_list(Tail).


rybki(Who) :-
    Houses = [
        house(_Color1, _Nationality1, _Drink1, _Pet1, _Smokes1),
        house(_Color2, _Nationality2, _Drink2, _Pet2, _Smokes2),
        house(_Color3, _Nationality3, _Drink3, _Pet3, _Smokes3),
        house(_Color4, _Nationality4, _Drink4, _Pet4, _Smokes4),
        house(_Color5, _Nationality5, _Drink5, _Pet5, _Smokes5)
    ],
    /* 01 */ first(      house(_,      norwegian,_,     _,     _),         Houses),
    /* 02 */ exists(     house(red,    english,  _,     _,     _),         Houses),
    /* 03 */ left_of(    house(white,  _,        _,     _,     _),         house(green,_,_,_,_), Houses),
    /* 04 */ exists(     house(_,      danish,   tea,   _,     _),         Houses),
    /* 05 */ next_to(    house(_,      _,        _,     _,     light),     house(_,_,_,cat,_), Houses),
    /* 06 */ exists(     house(yellow, _,        _,     _,     cigar),     Houses),
    /* 07 */ exists(     house(_,      german,   _,     _,     pipe),      Houses),
    /* 08 */ middle(     house(_,      _,        milk,  _,     _),         Houses),
    /* 09 */ next_to(    house(_,      _,        _,     _,     light),     house(_,_,water,_,_), Houses),
    /* 10 */ exists(     house(_,      _,        _,     bird,  nofilter),  Houses),
    /* 11 */ exists(     house(_,      swedish,  _,     dog,   _),         Houses),
    /* 12 */ next_to(    house(_,      norwegian,_,     _,     _),         house(blue,_,_,_,_), Houses),
    /* 13 */ next_to(    house(_,      _,        _,     horse, _),         house(yellow,_,_,_,_), Houses),
    /* 14 */ exists(     house(_,      _,        beer,  _,     menthol),   Houses),
    /* 15 */ exists(     house(green,  _,        coffee,_,     _),         Houses),
    exists(     house(_,      Who,      _,     fish,  _),         Houses),
    print_list(Houses).
