import ply.lex as lex

tokens = ('PAL','RESTO')
  
def t_U(t):
    r'[a-z]+'
    print (t.value.upper(), end="")
        
def t_RESTO (t):
 r'.|\n'
 print (t.value, end="")
## PADRÃO DAQUI PARA BAIXO
def t_error(t):
 print("Illegal character '%s'" % t.value[0])
 t.lexer.skip(1)
 
lexer=lex.lex()
import sys
if len(sys.argv) < 2 :
 sys.exit("Usage: %s <filename>" % sys.argv[0])
 
fp = open(sys.argv[1])
contents=fp.read()
lexer.input(contents)
for token in lexer:
 pass
