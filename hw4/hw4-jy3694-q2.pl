/*Q 2.1*/
remove_helper([_], [], []).
remove_helper([I], [I|Ls], O):- remove_helper([I], Ls, O), !.
remove_helper([I], [L|Ls], [L|Os]):- remove_helper([I], Ls, Os), !.

remove_items([I], L, O) :- remove_helper([I], L, O), !.
remove_items([I|Is], L, O) :- remove_items([I], L, Left), remove_items(Is, Left, O).

/*Q 2.2*/
isList([]).
isList([_|T]) :- isList(T).

my_flatten([], []).
my_flatten(L1, [L1]) :- not(isList(L1)), !.
my_flatten([L|L1], L2) :- my_flatten(L, X), my_flatten(L1, Xs), append(X, Xs, L2), !.

/*Q 2.3*/
compress([], []).
compress([L1], [L1]).
compress([L1_1, L1_2|L1], L2) :- L1_1 = L1_2, compress([L1_2| L1], L2), !.
compress([L1_1, L1_2|L1], [L1_1|L2]) :- compress([L1_2|L1], L2).

/*Q 2.4*/
len([ ], 0).
len([_|T], N):- len(T, N1), N is N1 + 1.

list_list([], [[]]).
list_list([X], [[X]]).
list_list([X1, X2| L1], [[X1| L2_inner]| L2_outer]) :- X1 = X2, list_list([X2| L1], [L2_inner | L2_outer]), !.
list_list([X1, X2| L1], [[X1]| L2_outer]) :- list_list([X2| L1], L2_outer).

encode_helper([], []).
encode_helper([[H| T0] | T], [[N, H]|O]) :- len([H| T0], N), encode_helper(T, O).

encode(L1,L2) :- list_list(L1,L), encode_helper(L,L2).

/*Q 2.5*/
encode_modified_helper([], []).
encode_modified_helper([[N, L]|T], [L|O]) :- N =1, encode_modified_helper(T, O), !.
encode_modified_helper([[N, L]|T], [[N, L]|O]) :- encode_modified_helper(T, O), !.

encode_modified(L1,L2) :- encode(L1, L), encode_modified_helper(L, L2). 


/*Q 2.6*/
reverse([], []).
reverse([X|Xs], Zs) :- reverse(Xs, Ys), append(Ys, [X], Zs).

cut_left(_, 0, []).
cut_left([X|Xs], N, [X|O]) :-  N1 is N - 1, cut_left(Xs, N1, O).

cut_right(Xs, N, O) :- reverse(Xs, L), len(Xs, N1), M is N1 - N, cut_left(L, M, T), reverse(T, O).

rotate(L1, N, L2) :- N > 0, cut_left(L1, N, Right), cut_right(L1, N, Left), append(Left, Right, L2), !.
rotate(L1, N, L2) :- len(L1, N1), M is N1 + N, rotate(L1, M, L2).
