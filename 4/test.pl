s(L,O):-s(L,0,O),O=[_|_].
s([],0,[]).
s([H|T],S,[H|P]):-R is H+S,s(T,R,P).
s([_|T],S,O):-s(T,S,O).
