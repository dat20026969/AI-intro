female('ElizabethII').
female('Diana').
female('CamillaParkerBowles').
female('SarahFerguson').
female('KateMiddleton').
female('MeghanMarkle').
female('Eugenie').
female('Beatrice').
female('Charlotte').
female('Anne').
female('SophieRhys-Jones').
female('AutumnPhilips').
female('ZaraTindall').
female('LadyLouiseWindsor').

male('Philip').
male('Charles').
male('Andrew').
male('William').
male('Harry').
male('George').
male('Louis').
male('ArchieHarrison').
male('MarkPhillips').
male('TimothyLaurence').
male('Edward').
male('PeterPhillips').
male('MikeTindall').
male('James').

parent('ElizabethII', 'Charles').
parent('ElizabethII', 'Anne').
parent('ElizabethII', 'Andrew').
parent('ElizabethII', 'Edward').

parent('Philip', 'Charles').
parent('Philip', 'Anne').
parent('Philip', 'Andrew').
parent('Philip', 'Edward').

parent('Diana', 'William').
parent('Diana', 'Harry').
parent('Charles', 'William').
parent('Charles', 'Harry').

parent('MarkPhillips', 'PeterPhillips').
parent('MarkPhillips', 'ZaraTindall').
parent('Anne', 'PeterPhillips').
parent('Anne', 'ZaraTindall').

parent('Ferguson', 'Beatrice').
parent('Ferguson', 'Eugenie').
parent('Andrew', 'Beatrice').
parent('Andrew', 'Eugenie').

parent('SophieRhys-Jones', 'James').
parent('SophieRhys-Jones', 'LadyLouiseWindsor').
parent('Edward', 'James').
parent('Edward', 'LadyLouiseWindsor').

parent('William', 'George').
parent('William', 'Charlotte').
parent('William', 'Louis').
parent('KateMiddleton', 'George').
parent('KateMiddleton', 'Charlotte').
parent('KateMiddleton', 'Louis').

parent('Harry', 'ArchieHarrison').
parent('MeghanMarkle', 'ArchieHarrison').


married('ElizabethII', 'Philip').
married('Philip', 'ElizabethII').
married('Charles', 'CamillaParkerBowles').
married('MarkPhillips', 'Charles').
married('Anne', 'TimothyLaurence').
married('TimothyLaurence', 'Anne').
married('Edward', 'SophieRhys-Jones').
married('SophieRhys-Jones', 'Edward').
married('William', 'KateMiddleton').
married('KateMiddleton', 'William').
married('AutumnPhillips', 'PeterPhillips').
married('PeterPhillips', 'AutumnPhillips').
married('ZaraTindall', 'MikeTindall').
married('MikeTindall', 'ZaraTindall').

divorced('Charles', 'Diana').
divorced('Diana', 'Charles').
divorced('Anne', 'MarkPhillips').
divorced('MarkPhillips', 'Anne').
divorced('SarahFerguson', 'Andrew').
divorced('Andrew', 'SarahFerguson').

husband(Person, Wife) :-
    married(Person, Wife),
    male(Person).
wife(Person, Husband) :-
    married(Person, Husband),
    female(Person).
father(Parent, Child) :-
    male(Parent),
    parent(Parent, Child).
mother(Parent, Child) :-
    female(Parent),
    parent(Parent, Child).
child(Child, Parent) :-
    parent(Parent, Child).
son(Child, Parent) :-
    male(Child),
    parent(Parent, Child).
daughter(Child, Parent) :-
    female(Child),
    parent(Parent, Child).
grandparent(GP, GC) :-
    parent(GP, X),
    parent(X, GC).
grandmother(GM, GC) :-
    female(GM),
    parent(GM, X),
    parent(X, GC).
grandfather(GF, GC) :-
    male(GF),
    parent(GF, X),
    parent(X, GC).
grandchild(GC, GP) :-
    grandparent(GP, GC).
grandson(GS, GP) :-
    male(GS),
    grandchild(GS, GP).
granddaughter(GD, GP) :-
    female(GD),
    grandchild(GD, GP).
sibling(Person1, Person2) :-
  setof((Person1,Person2), P^(parent(P,Person1),parent(P,Person2), \+Person1=Person2), Sibs),
  member((Person1,Person2), Sibs),
  \+ (Person2@<Person1, member((Person2,Person1), Sibs)).
brother(Person, Sibling) :-
    male(Person),
    sibling(Person, Sibling).
sister(Person, Sibling) :-
    female(Person),
    sibling(Person, Sibling).
aunt(Person, NieceNephew) :-
    (female(Person),
    parent(X, NieceNephew),
    sibling(X, Person));
    (female(Person),
    married(Person, Y),
    male(Y),
    brother(Y, Z),
    parent(Z, NieceNephew));
    (female(Person),
    married(Person, Someone),
    sibling(P1, P2),
    (parent(P1, Someone), parent(P2, SomeoneElse)),
    parent(SomeoneElse, NieceNephew)).
uncle(Person, NieceNephew) :-
    (male(Person),
    parent(X, NieceNephew),
    sibling(X, Person));
    (male(Person),
    married(Person, Y),
    female(Y),
    sister(Y, Z),
    parent(Z, NieceNephew));
    (male(Person),
    married(Person, Someone),
    sibling(P1, P2),
    (parent(P1, Someone), parent(P2, SomeoneElse)),
    parent(SomeoneElse, NieceNephew)).
niece(Person, AuntUncle) :-
    (uncle(AuntUncle, Person); aunt(AuntUncle, Person)),
    female(Person).
nephew(Person, AuntUncle) :-
    (uncle(AuntUncle, Person); aunt(AuntUncle, Person)),
    male(Person).

firstCousin(X,Y) :- grandparent(Z,X),grandparent(Z,Y),not(sibling(X,Y)),X \= Y.
spouse(X,Y) :- married(X,Y),married(Y,X).


