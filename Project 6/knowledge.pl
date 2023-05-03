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
female(made_up_helen_sister).

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
parent_of(doreen, made_up_helen_sister).
parent_of(colin, made_up_helen_sister).

married_to(john, mary).
married_to(mary, john).
married_to(colin, doreen).
married_to(doreen, colin).
married_to(stephen, helen).
married_to(helen, stephen).
married_to(liam, helen_2).
married_to(helen_2, liam).

father_of(X, Y) :- parent_of(X, Y), male(X).
mother_of(X, Y) :- parent_of(X, Y), female(X).

son_of(X, Y) :- father_of(Y, X).
daughter_of(X, Y) :- mother_of(Y, X).

sibling_of(X, Y) :- parent_of(Z, X), parent_of(Z, Y), X \= Y.

brother_of(X, Y) :- sibling_of(X, Y), male(X).
sister_of(X, Y) :- sibling_of(X, Y), female(X).

grandparent_of(X, Y) :- parent_of(X, Z), parent_of(Z, Y).

ancestor_of(X, Y) :- parent_of(X, Y).
ancestor_of(X, Y) :- parent_of(X, Z), ancestor(Z, Y).

uncle_of(X, Y) :- brother_of(X, Z), parent_of(Z, Y) ; married_to(X, Z), sister_of(Z, W), parent_of(W, Y).
aunt_of(X, Y) :- sister_of(X, Z), parent_of(Z, Y) ; married_to(X, Z), brother_of(Z, W), parent_of(W, Y).

cousin_of(X, Y) :- parent_of(Z, X), parent_of(W, Y), sibling_of(Z, W).

brother_in_law_of(X, Y) :- married_to(X, Z), brother_of(Z, Y).
sister_in_law_of(X, Y) :- married_to(X, Z), sister_of(Z, Y).

father_in_law_of(X, Y) :- father_of(X, Z), married_to(Z, Y) ; mother_of(X, Z), married_to(Z, Y).
mother_in_law_of(X, Y) :- father_of(X, Z), married_to(Y, Z) ; mother_of(X, Z), married_to(Y, Z).