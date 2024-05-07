potencia(_,0,1).
potencia(B,E,P):-E1 is E-1, potencia(B, E1, P1), P is B*P1.

fatorial(1,1).
fatorial(N,F):-N1 is N-1, fatorial(N1,F1), F is F1*N.

even(N):- X is N mod 2, X==0.

segment(point(X,Y), point(Z,K)).

vertical(segment(point(X,Y), point(X,Y1)).
horizontal(segment(point(X,Y1)).
