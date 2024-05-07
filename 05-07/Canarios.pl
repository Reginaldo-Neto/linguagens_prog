:-dynamic canary/6.
:-dynamic son/3.
%Aqui em cima, é o nome da classe e a quantidade de atributos.
canary(name(homer), color(orange), gender(male), date(2019-
5-1), place(braganca), state(alive)).

canary(name(marge), color(orange), gender(female),
date(2019-4-10), place(porto), state(dead)).

canary(name(bart), color(dark_orange), gender(male),
date(2019-12-5), place(braganca), state(dead)).

son(name(bart), father(homer), mother(marge)).

%Função sem parametros
%O findall consiste em: QUAL ATRIBUTO EU QUERO COLECIONAR DENTRO DO S (S é a minha saída do find, deve ser o ultimo item antes de fehcar os parenteses do findall). Nos atributos no meio são as condições para que eu faça a seleção.

print_nomes :- findall(NOME,
               canary(name(NOME),_,_,_,_,_),S),
               write(S).

%%AQUI EMBAIXO VAMOS TRATAR ENTRADAS DINÂMICAS EM TEMPO REAL

%Se conseguiu chegar na !, vai para o que tiver embaixo.
%Sempre que for inserir no executável lembrar do ponto final
%Se for escrever maiusculo precisa de aspas simples.
insert_canarys :- write('name:'), read(A),
                  write('color:'), read(B),
                  write('gender:'), read(C),
                  write('date:'), read(D),
                  write('place:'), read(E),
                  write('state:'), read(F),
		  !,
		  assert(canary(name(A),
				color(B),
				gender(C),
				date(D),
				place(E),
				state(F))).

insert_rel :-     write('name:'), read(A),
                  write('faher:'), read(B),
                  write('mother:'), read(C),
                  !,
		  assert(son(name(A),
                             father(B),
                             mother(C))).

count_male :- findall(A,
                      canary(name(A),_,gender(male),_,_,_),S),
              length(S,N),
              write(N).
%DESCOBRIR QUEM É PARENTE DE QUEM:

father(B,A) :- son(name(A), father(B),_).
mother(B,A) :- son(name(A), _, mother(B)).

brothers(A,B) :- son(name(A), father(X),_),
                 son(name(B), father(X),_),
                 not(A=B).
brothers(A,B) :- son(name(A), _, mother(X)),
                 son(name(B), _, mother(X)),
                 not(A=B).

%Seta significa oq eu quero fazer caso o lado esquerdo seja vdd
% Ponto-CVirgula significa que depois do ! não é pra passar adiante,
% signifca que vai ter outras condições.
%ISSO VAI SER UM SWITCH CASE.
% A ! não deixa o fail voltar pra cima, para ali e retorna false% caso
% nao entre em nenhum switch
degree :- (mother(A,B) -> write('Mother-Son'),!;
          father(A,B) -> write('Father-Son'),!;
          mother(B,A) -> write('Son-Mother'),!;
          father(B,A) -> write('Son-Father'),!;
          brothers(A,B) -> write('Brothers'),!;
          fail).


