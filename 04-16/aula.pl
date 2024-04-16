speaks(ines, russian).
speaks(rui, english).
speaks(maria, russian).
speaks(maria, english).

speaks_with(X,Y):-speaks(X,L), speaks(Y,L).
speaks_with(X,Y):-speaks(X,L), speaks(Y,L), X\=Y.


mother(rosa,lucas).
father(lucas,ana).

grand_parent(X,Y):-parent(X,Z), parent(Z,Y).
parent(X,Y):-mother(X,Y).
parent(X,Y):-father(X,Y).

likes(joao, maria).
girl(maria).


parents(rosa,joao,sons(ana,maria,jorge),address(bragan�a)).

some(X,Y,Z):- Z is X+Y.
sub(X,Y,Z):- Z is X-Y.
mul(X,Y,Z):- Z is X*Y.
program:- read(X),read(Y),some(X,Y,Z),write(Z).


student(name(joao),grades(12,13,14,15)).
student(name(maria),grades(14,16,17,12)).

first(X,N):- student(name(X),grades(N,_,_,_)).

third(X):- student(name(X),grades(_,_,N,_)),N>=10,!,wirte("Approved").
third(_):- write("Failed").

third(X):- student(name(X),grades(_,_,N,_)),N>=10->wirte("Approved").
third(_):- write("Failed").

average(X):-student(name(X),grades(A,B,C,D)),M is (A+B+C+D)/4.0, write(X), write('M�dia: '),write(M),nl.

average():-student(name(X),grades(A,B,C,D)),
    M is (A+B+C+D)/4, write(X),
    write('-'),write(M),nl,fail.

