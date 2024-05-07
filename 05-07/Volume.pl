%aqui em cima vem a base de cinhecimento

box(r1, measurements(23,34,12)).
box(r2, measurements(20,20,10)).
box(r3, measurements(12,34,34)).
box(r4, measurements(34,3,12)).
box(r5, measurements(6,8,11)).
% Defini a função que recebe um nome(Model), e vai caçar esse nome no
% banco e salva seus atributos em A,B,C. Depois retorna o valor em
% Volume.
% Lá no executável o atributo no lugar de volume tem que ter NOME em
% maiusculo pq é uma variavel. Lembrar de usar o nome SAIDA pra ficar
% facil de entender.
volume(Model, Volume) :-
    box(Model, measurements(A,B,C)),
    Volume is A * B * C.
%IF ELSE pra saber qual a letra q veio pro parametro pra saber
% o que vou devolver. Uso o _ pra ignorar oq estiver vindo naqueles
% paramentro. mas preciso usa-los por conta da ordem no banco
measure(Model, a, A):-box(Model, measurements(A, _, _)).
measure(Model, l, B):-box(Model, measurements(_, B, _)).
measure(Model, p, C):-box(Model, measurements(_, _, C)).
% ao chamar essa função, ela chama a subrotina de volume que calcula o
% volume de todos os Model faz o if else se é maior que vinte e escreve
% de volta o nome do model.
higher :- volume(Model,Vol), Vol>20,
 write(Model),fail.

higher2 :- findall(K, (volume(K,V), V>20),S),
 write(S).

the_same :- box(Model, measurements(X,X,_)),
    write(Model),fail.

the_same2 :- findall(Model,
                     box(Model,measurements(X,X,_)),S),
             write(S).

%Calcula quantas caixas tem a profundidade maior que 15 metros

count_higher :- findall(Model,
                       (box(Model,measurements(_,_,Z)),Z>15),S),
             length(S,N),
             write(N).
%Calcular quantas caixas tem o volume total entre 500 e 1000

count_between :- findall(Model,
                         (volume(Model,SAIDA),
                          SAIDA>=500, SAIDA=<10000), S),
    length(S,N),
    write(S),
    write(" - "),
    write(N).
