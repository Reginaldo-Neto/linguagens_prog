tokens = (
    'SON', 'PESSOA', 'VIR', 'APAR', 'FPAR'
)
literais = ",()"
def t_SON(t): #PALAVRA RESERVADA TEM QUE SER FEITA PRIMEIRO
    r'SON'
    return t
def t_PESSOA(t):
    r'[a-zA-Z]+'
    return t
t_VIR = r'\,'
t_APAR = r'\('
t_FPAR = r'\)'
t_ignore = " \t\n"

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

# Build the lexer
import ply.lex as lex
lexer = lex.lex()

# Parsing rules
def p_def_prog(t):
    'prog : relacoes'
    
def p_def_relacoes(t):
    '''relacoes : relacao
    | relacoes relacao'''
        
def p_def_relacao(t):
    'relacao : SON APAR PESSOA VIR PESSOA FPAR'
    pai = t[3]
    filho = t[5]
    print(pai,"->", filho) 
    
def p_error(t):
    print("Syntax error at '%s'" % t.value)
import ply.yacc as yacc
parser = yacc.yacc()
import sys
if len(sys.argv) < 2 :
    sys.exit("Usage: %s <filename>" % sys.argv[0])
fp = open(sys.argv[1])
contents=fp.read()
print("digraph{")
result=parser.parse(contents) 
print("}")


#Ao inves da linha 47 e 49, é possivel tem statements vazios

# def p_def_def(t):
#   'def: begin relacoes end'

#def begin(t):
#   'begin : '
#    print("digraph{")

#def end(t):
#   'end : '
#    print("}")