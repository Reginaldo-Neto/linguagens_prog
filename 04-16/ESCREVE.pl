element(X,[X|_]).
element(X,[_|Y]):- element(X,Y).

writing([]).
writing([X|Y]):-write(X),nl,writing(Y).

size([],0).
size([X|Y],N) :- size(Y,N1), N is N1 + 1.

suml([],0).
suml([X|Y],N) :- suml(Y,N1), N is N1 + X.

app([],X,X).
app([X|Y],K,[X|Z]) :- app(Y,K,Z).