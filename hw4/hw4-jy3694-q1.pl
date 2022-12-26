male(tom).
male(brian).
male(kevin).
male(zhane).
male(fred).
male(jake).
male(bob).
male(stephen).
male(paul).

parent(tom,stephen).
parent(stephen,jennifer).
parent(tom,mary).

parent(melissa,brian).
parent(mary,sarah).
parent(bob,jane).
parent(paul,kevin).
parent(jake,bob).
parent(zhane,melissa).
parent(stephen,paul).
parent(emily,bob).
parent(zhane,mary).

grandfather(X,Y) :- male(X), parent(X,Z),parent(Z,Y).

female(jennifer).
female(mary).
female(melissa).
female(sarah).
female(jane).
female(emily).
aunt(X, Y) :- female(X), parent(U, X), parent(U, V), parent(V, Y). 
uncle(X, Y) :- male(X), parent(U, X), parent(U, V), parent(V, Y). 
/*
Question 1
I rearrange male(tom). to be at the first line(line 1).
Move parent(tom, stephen). to be the first line(line 11) of parent facts
Move parent(stephen, jennifer). to be the second line(line 12) of parent facts
*/

/*
Question 2
Since prolog interpreter explores the tree depth first, from left to right.
It starts at the beginning of the database. Thus, we should put facts in the 
order that minimizes the backtracking. 

Considering how prolog would go about finding answer for 

grandfather(tom, jennifer) :- male(tom), parent(tom, Z), parent(Z, jennifer)

We should add the database in this order where the prolog would find male(tom) first, 
parent(tom, Z) second and parent(Z, jennifer) the last. 

Here is the trace for the modified version:
[trace]  ?- grandfather(tom, jennifer).
   Call: (10) grandfather(tom, jennifer) ? creep
   Call: (11) male(tom) ? creep
   Exit: (11) male(tom) ? creep
   Call: (11) parent(tom, _18310) ? creep
   Exit: (11) parent(tom, stephen) ? creep
   Call: (11) parent(stephen, jennifer) ? creep
   Exit: (11) parent(stephen, jennifer) ? creep
   Exit: (10) grandfather(tom, jennifer) ? creep
true .

Here is the trace for the old version:
[trace]  ?- grandfather(tom, jennifer).
   Call: (10) grandfather(tom, jennifer) ? creep
   Call: (11) male(tom) ? creep
   Exit: (11) male(tom) ? creep
   Call: (11) parent(tom, _18310) ? creep
   Exit: (11) parent(tom, mary) ? creep
   Call: (11) parent(mary, jennifer) ? creep
   Fail: (11) parent(mary, jennifer) ? creep
   Redo: (11) parent(tom, _18310) ? creep
   Exit: (11) parent(tom, stephen) ? creep
   Call: (11) parent(stephen, jennifer) ? creep
   Exit: (11) parent(stephen, jennifer) ? creep
   Exit: (10) grandfather(tom, jennifer) ? creep
true .
*/

/*
Question 3
One may tempt to write
 grandmother(X, Y) :- not(male(X)), parent(X, Z), parent(Z, Y).
However, a not expression generally indicates inability to prove -not falsehood. 
(It could be that a particular X is male, but no such fact was ever asserted.) 

For example: 
grandmother(melissa, Y) :- not(male(melissa)), parent(melissa, Z), parent(Z, Y). 
Prolog doesn't know if melissa is male or female. It will return not(male(melissa)) = true.
*/

/*
Question 4
We define more fact to assert that mary is female.
To check if X is aunt of Y. We need to check if X is female.
We also need to check if aunt X has grandparent U who has kid V, where V is a parent of Y. 

To check if X is uncle of Y. We need to check if X is male.
We also need to check if uncle X has grandparent U who has kid V, where V is a parent of Y. 
*/