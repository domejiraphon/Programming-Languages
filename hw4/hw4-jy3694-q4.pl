/*Q 4.1*/
time(P, T) :- P = tokyo, T is 5.
time(P, T) :- P = rio, T is 10.
time(P, T) :- P = berlin, T is 20.
time(P, T) :- P = denver, T is 25.

/*Q 4.2*/
team([tokyo, rio, denver, berlin]).

/*Q 4.3*/
cost_mapper([], []).
cost_mapper([X|Xs], [T|L]) :- time(X, T), cost_mapper(Xs, L).

max([], Tmp, Tmp).
max([X|Xs], Tmp, L) :- X > Tmp, max(Xs, X, L).
max([_|Xs], Tmp, L) :- max(Xs, Tmp, L), !.
max([X|Xs], L) :- max([X|Xs], X, L).

cost([], 0).
cost(Xs, C) :- cost_mapper(Xs, T), max(T, C).

/*Q 4.4*/
split(L,[X,Y],M) :- 
  member(X,L),
  member(Y,L),
  compare(<,X,Y),
  subtract(L,[X,Y],M).

move(st(l,L1), st(r,L2), r(M), C) :- split(L1, M, L2), cost(M, C).
move(st(r, L1), st(l, [M|_]), l([M]), C) :- not(member(M, L1)),  time(M, C), !.
move(st(r, L1), st(l, [_|L2]), l([M]), C) :- move(st(r, L1), st(l, L2), l([M]), C).

/*Q 4.5*/
random_helper(X, [X|Tmp], Tmp).
random_helper(X, [Y|Tmp], [Y|L]) :- random_helper(X, Tmp, L).
random([], []).
random([X|L], O) :- random(L, Tmp), random_helper(X, O, Tmp).

delete(X, [X|L], L).
delete(X, [H|T], [H|O]) :- delete(X, T, O).
delete_list([], T, T).
delete_list([X|L], T, O) :- delete(X, T, Tmp), delete_list(L, Tmp, O).

random_fixed(L, O) :- go_first(L, Tmp), delete_list(Tmp, L, Not), append(Tmp, Not, O).
go_first(L, O):- go_first_helper(L, O), length(O, Len), Len = 2.

go_first_helper(_, []).
go_first_helper([H|T], [H|O]) :- go_first_helper(T, O).
go_first_helper([_|T], [H|O]) :- go_first_helper(T, [H|O]).

right(_, [], []).
right(T, [H|L], [H|O]) :- not(member(H, T)), right(T, L, O).
right(T, [_|L], O) :- right(T, L, O).

right_helper(T, O) :- team(All), right(T, All, O), !.
trans(st(l, []), st(r, []), [], 0):- !.
trans(st(l, [X]), st(r, []), [], C) :- time(X, C), !.
trans(st(l, [X, Y]), st(r, []), [r(M)], C) :-
  move(st(l, [X, Y]), st(r, _), r(M), C), !.
trans(st(r, []), st(l, _), [], 0) :- !.

trans(st(l, L1), st(r, L2), [r(T) | M], C) :-
  random_fixed(L1, [X, Y|Perm_L1]),
  move(st(l, [X, Y|Perm_L1]), st(r, Perm_L1), r(T), C1), 
  right_helper(Perm_L1, CBack),
  member(Back, CBack),
  trans(st(r, Perm_L1), st(l, [Back|Perm_L1]), M, C2), 
  C is C1 + C2.

trans(st(r, L1), st(l, L2), [l(Z) | M], C) :-
  move(st(r, L1), st(l, L2), l([Z]), C1), 
  trans(st(l, L2), st(r, []), M, C2), 
  C is C1 + C2.

cross(M,D) :-
  team(T),
  trans(st(l,T),st(r,[]),M,D0),
  D0=<D.

solution(M) :- cross(M,60).