male(joshua).
male(stephen).
male(john).
male(colin).
male(liam).

female(helen).
female(helen_2).
female(mary).
female(emma).
female(kate).
female(doreen).

parent_of(liam, emma).
parent_of(liam, kate).
parent_of(helen_2, emma).
parent_of(helen_2, kate).
parent_of(doreen, helen).
parent_of(colin, helen).
parent_of(mary, stephen).
parent_of(john, stephen).
parent_of(helen, joshua).
parent_of(stephen, joshua).
parent_of(mary, liam).
parent_of(stephen, liam).


father_of(X, Y) :- parent_of(X, Y), male(X).
mother_of(X, Y) :- parent_of(X, Y), female(X).

son_of(X, Y) :- father_of(Y, X).
daughter_of(X, Y) :- mother_of(Y, X).

sibling_of(X, Y) :- parent_of(Z, X), parent_of(Z, Y), X \= Y.

brother_of(X, Y) :- sibling_of(X, Y), male(X).
sister_of(X, Y) :- sibling_of(X, Y), female(X).
