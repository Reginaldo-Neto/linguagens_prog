tokens = (
    'NAME', 'VIR', 'APAR', 'FPAR', 'NUM'
)
literais = ",()"
def t_NAME(t):
    r'[a-zA-Z]+'
    return t
def t_NUM(t):
    r'[0-9]+'
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
    'prog : students'
    print(t[1]) #Printa a maior media geral
    
def p_def_students(t):
    '''students : student
    | students student'''
    if (len(t) == 2):
        t[0] = t[1] #Se exite apenas 1 aluno a maior media é dele
    elif (len(t) == 3):
        t[0] = max(t[1], t[2]) #Pega a maior media e manda pra "cima"
        
def p_def_student(t):
    'student : NAME NUM APAR NUM VIR NUM VIR NUM VIR NUM FPAR'
    t[0]= (int(t[4])+int(t[6])+int(t[8])+int(t[10]))/4 
    print(t[0]) #Só para mostrar a media de cada aluno
    
def p_error(t):
 print("Syntax error at '%s'" % t.value)
import ply.yacc as yacc
parser = yacc.yacc()
import sys
if len(sys.argv) < 2 :
 sys.exit("Usage: %s <filename>" % sys.argv[0])
fp = open(sys.argv[1])
contents=fp.read()
result=parser.parse(contents) 