

% Board:
% (0,0)---(1,0)---(2,0)---(3,0)
%   |       |       |       |
%   |       |       |       |
% (0,2)---(1,1)---(2,1)---(3,1)
%   |       |       |       |
%   |       |       |       |
% (0,3)---(1,3)---(2,3)---(3,3)
%   |       |       |       |
%   |       |       |       |
% (0,4)---(1,4)---(2,4)---(3,4)
m(1,2). m(1,5).
m(2,3). m(2,6).
m(3,4). m(3,7).
m(4,8).
m(5,6). m(5,9).
m(6,7). m(6,10).
m(7,8). m(7,11).
m(8,12).
m(9,10). m(9,13).
m(10,11). m(10,14).
m(11,12). m(11,15).
m(12,16).
m(13,14).
m(14,15).
m(15,16).

m(X,Y) :- m(Y,X).

board(X, Num) :-
    Board = [
        m(1,2),     m(1,5),
        m(2,3),     m(2,6),
        m(3,4),     m(3,7),
        m(4,8),
        m(5,6),     m(5,9),
        m(6,7),     m(6,10),
        m(7,8),     m(7,11),
        m(8,12),
        m(9,10),    m(9,13),
        m(10,11),   m(10,14),
        m(11,12),   m(11,15),
        m(12,16),
        m(13,14),
        m(14,15),
        m(15,16)],
    remove(Num, Board, X).


large(X) :-
    X = [m(1,2),m(2,3),m(3,4),m(4,8),m(8,12),m(12,16),m(16,15),m(15,14),
        m(14,13),m(13,9),m(9,5),m(5,1)].

medium(X) :-
    member(X, [
        [m(1,2),m(2,3),m(3,7),m(7,11),m(11,10),m(10,9),m(9,5),m(5,1)],
        [m(2,3),m(3,4),m(4,8),m(8,12),m(12,11),m(11,10),m(10,6),m(6,2)],
        [m(5,6),m(6,7),m(7,11),m(11,15),m(15,14),m(14,13),m(13,9),m(9,5)],
        [m(6,7),m(7,8),m(8,12),m(12,16),m(16,15),m(15,14),m(14,10),m(10,6)]
    ]).

small(X) :-
    member(X, [
        [m(1,2),m(2,6),m(5,6),m(1,5)],
        [m(2,3),m(3,7),m(6,7),m(2,6)],
        [m(3,4),m(4,8),m(8,7),m(3,7)],
        [m(5,6),m(6,10),m(10,9),m(5,9)],
        [m(6,7),m(7,11),m(11,10),m(6,10)],
        [m(7,8),m(8,12),m(11,12),m(7,11)],
        [m(9,10),m(10,14),m(13,14),m(9,13)],
        [m(10,11),m(11,15),m(14,15),m(10,14)],
        [m(11,12),m(12,16),m(15,16),m(11,15)]
    ]).
