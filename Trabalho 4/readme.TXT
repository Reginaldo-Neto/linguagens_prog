TRABALHO 4 - HASKELL
REGINALDO GREGÓRIO DE SOUZA NETO
a61482

Funções diferentes que pesquisei e usei no trabalho.
Da biblioteca Control.Monad, usei o forM_ para iterar sobre cada classe interpretanto elas como monadas e printando seus valores na listagem das classes.
Também usei o Data.list para fazer um database com as relações criadas, e fiz um filter na inserção de cada relação para garantir que só tenha uma relação entre duas classes.
Também converti tudo para string para fazer um mapeamento antes de "jogar" no arquivo de saida e gerar o código em mermaid.

INSTRUÇÕES DE USO:
Não é preciso usar ASPAS para digitar as palavras e o winhugs NÃO ACEITA o uso do backspace, caso seja clicado ele armazenará o "\b"
Vou usar o # para comentários aqui no readme
Exemplo de uso:

main

#------------------Criação das classes------------------
#------------------Primeira classe------------------
2
pessoa
String nome Int idade
getNome() getIdade()
#------------------Segunda classe------------------
2
animal
String raca float peso int dentes
{Linha vazia "em branco", para testar método vazio}
#------------------Terceira classe------------------
2
gato
{Linha vazia "em branco", para testar atributo vazio}
miar()

#------------------Criação dos relacionamentos------------------
#------------------Primeiro relacionamento------------------
3
pessoa
4
2
5
animal
#------------------Segundo relacionamento------------------
3
gato
6
1
2
pessoa
#------------------Terceiro relacionamento------------------
3
gato
0
1
0
animal
#------------------Contagem dos atributos------------------
4
pessoa
4
animal
4
gato
#------------------Listar as classes------------------
1
#------------------Gerar o diagrama------------------
5
#------------------Finalizar o programa------------------
0
