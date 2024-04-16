import ply.lex as lex

tokens = ('DATA','RESTO')
  
def t_DATA(t):
    #r'[0-9]{2}\/[0-9]{2}\/[0-9]{2}'
    r'[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9][0-9][0-9]'
    print (t.value[6]+t.value[7]+t.value[8]+t.value[9]+"-"+t.value[3]+t.value[4]+"-"+t.value[0]+t.value[1],end="") 

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
