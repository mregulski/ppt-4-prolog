% utilities
% put elements from A into S
select([A|As], S) :- select(A, S, S1), select(As, S1).
select([], _).
% relative locations
next_to(A,B,Houses) :- left_of(A,B,Houses).
next_to(A,B,Houses) :- left_of(B,A,Houses).
left_of(A,B,Houses) :- append(_,[A,B|_],Houses).

% House representation:
% h(color, nation, pet, drink, smokes)

% color:    red, green, white, yellow, blue
% nation:   norwegian, english, danish, german, swedish
% pet:      cat, bird, dog, horse, fish
% drink:    tea, milk, water, beer, coffee
% smokes:   light, cigar, pipe, nofilter, menthol
rybki(Who) :-
    rybki(Who, _).


rybki(Who, Houses) :-
    % rules 1 & 8
    Houses = [ h(_,norwegian,_,_,_), _, h(_,_,_,milk,_), _, _],
    select([
        h(red,english,_,_,_),       % rule 2
        h(_,danish,_,tea,_),        % rule 4
        h(_,german,_,_,pipe),       % rule 7
        h(_,swedish,dog,_,_)        % rule 11
        ], Houses),

    select([
        h(yellow,_,_,_,cigar),      % rule 6
        h(_,_,birds,_,nofilter),    % rule 10
        h(_,_,_,beer,menthol)       % rule 14
        ], Houses),

    % rules 3 & 15
    left_of(h(green,_,_,coffee,_), h(white,_,_,_,_), Houses),

    % rule 5
    next_to(h(_,_,_,_,light), h(_,_,cat,_,_), Houses),

    % rule 9
    next_to(h(_,_,_,_,light), h(_,_,_,water,_), Houses),

    % rule 12
    next_to(h(_,norwegian,_,_,_), h(blue,_,_,_,_), Houses),

    % rule 13
    next_to(h(_,_,horse,_,_), h(yellow,_,_,_,_), Houses),

    % return
    member(h(_,Who,fish,_,_), Houses).
