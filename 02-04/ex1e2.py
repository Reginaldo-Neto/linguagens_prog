import ply.lex as lex

tokens = ('A', 'E', 'I', 'O', 'U','RESTO')
def t_A(t):
    r'[aA]'
    print (t.value[0] + "itz", end="")
    
def t_E(t):
    r'[eE]'
    print (t.value + "nder", end="")
    
def t_I(t):
    r'[iI]'
    print (t.value + "nix", end="")
    
def t_O(t):
    r'[oO]'
    print (t.value + "ver", end="")
    
def t_U(t):
    r'[uU]'
    print (t.value + "fux", end="")
        
def t_RESTO (t):
 r'.|\n'
 print (t.value, end="")

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
