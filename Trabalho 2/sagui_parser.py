tokens = (
    'TITULO',  'DIAGRAMA', 'GERAL', 'PALAVRA_CLASSES', 'PALAVRA_RELACOES',
    'ABRE_PAR', 'FECHA_PAR', 'RETA', 'MAIORQ', 'MENORQ', 'DOIS_PONTOS', 'PONTO_VIRGULA', 'VARIAVEL',
    'TIPO', 'LIST', 'PRIVACIDADE', 'CARDINALIDADE', 'TIPOS_RELACAO', 'ASPAS'
)
literals = ",();><|-*"

#AS PALAVRAS RESERVADAS DEVEM SER FEITAS PRIMEIRO
def t_ASPAS (t):
    r'\"'
    return t

def t_TITULO(t): 
    r'TITULO'
    return t

def t_DIAGRAMA(t): 
    r'DIAGRAMA'
    return t

def t_GERAL(t): 
    r'GERAL'
    return t

def t_PALAVRA_CLASSES(t): 
    r'CLASSES'
    return t

def t_PALAVRA_RELACOES(t): 
    r'RELACOES'
    return t

def t_INT(t):
    r'INT'
    t.value = "int"
    t.type = "TIPO"
    return t

def t_FLOAT(t):
    r'FLOAT'
    t.value = "float"
    t.type = "TIPO"
    return t

def t_STRING(t): 
    r'STRING'
    t.value="String"
    t.type = "TIPO"
    return t

def t_VOID(t): 
    r'VOID'
    t.value="void"
    t.type = "TIPO"
    return t

def t_LIST(t): 
    r'LIST'
    return t

def t_PUB(t): 
    r'PUB'
    t.type = "PRIVACIDADE"
    t.value = "+"
    return t

def t_PRI(t): 
    r'PRI'
    t.type = "PRIVACIDADE"
    t.value = "-"
    return t

def t_PRO(t): 
    r'PRO'
    t.type = "PRIVACIDADE"
    t.value = "#"
    return t

def t_PAC(t): 
    r'PAC'
    t.type = "PRIVACIDADE"
    t.value = "~"
    return t

def t_CARD_UM(t): 
    r'1'
    t.type = "CARDINALIDADE"
    return t

def t_CARD_UM_VARIOS(t): 
    r'1\*'
    t.type = "CARDINALIDADE"
    return t

def t_CARD_ZERO_VARIOS (t):
    r'0\*'
    t.type = "CARDINALIDADE"
    t.value = "0..*"
    return t

def t_CARD_ZERO_UM(t): 
    r'01'
    t.type = "CARDINALIDADE"
    return t

def t_CARD_VARIOS (t):
    r'\*'
    t.type = "CARDINALIDADE"
    return t

def t_REL_HERANCA_ESQ(t):
    r'<\|\-'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_HERANCA_DIR(t):
    r'\-\|>'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_COMPOSICAO_ESQ(t):
    r'\*\-'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_COMPOSICAO_DIR (t):
    r'\-\*'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_AGREGACAO_ESQ(t):
    r'o\-'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_AGREGACAO_DIR(t):
    r'\-o'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_ASSOCIACAO_ESQ(t):
    r'<\-'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_ASSOCIACAO_DIR(t):
    r'\->'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_DEPENDENCIA_ESQ(t):
    r'<\.'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_DEPENDENCIA_DIR(t):
    r'\.>'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_REALIZACAO_ESQ(t):
    r'<\|\.'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_REALIZACAO_DIR(t):
    r'\.\|>'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_SOLIDA(t):
    r'\-'
    t.type = "TIPOS_RELACAO"
    return t

def t_REL_TRACEJADA(t):
    r'\.'
    t.type = "TIPOS_RELACAO"
    return t

def t_VARIAVEL(t):
    r'[a-zA-Z_0-9]+'
    return t


t_DOIS_PONTOS = r':'
t_PONTO_VIRGULA = r'\;'
t_RETA = r'\|'
t_MAIORQ = r'>'
t_MENORQ = r'<'
t_ABRE_PAR = r'\('
t_FECHA_PAR = r'\)'
t_ignore = " \t\n"

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

    
#----------------------------------------------------------------------------------------------------
# Build the lexer
import ply.lex as lex
lexer = lex.lex()

# Parsing rules

def p_def_program(p):
    'program : comeco iniRelacoes iniClasses'
    p[0] = f"{p[1]}{p[2]}"
    print(p[0])
    
def p_def_comeco(p):
     'comeco : TITULO DOIS_PONTOS VARIAVEL DIAGRAMA GERAL DOIS_PONTOS'
     p[0] = f"%%{p[1]}{p[2]}{p[3]}\nclassDiagram\n\t"

def p_def_iniRelacoes(p):
    'iniRelacoes : MENORQ MENORQ PALAVRA_RELACOES relacoes MAIORQ MAIORQ'
    p[0]= p[4]
    
def p_def_relacoes(p):
    '''relacoes : relacao
    | relacoes relacao'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1] + p[2]
        
def p_def_relacao(p):
    'relacao : VARIAVEL ABRE_PAR interno_relacao FECHA_PAR VARIAVEL PONTO_VIRGULA'
    p[0] = f"{p[1]}{p[3]}{p[5]}\n"  
    
def p_interno_relacao(p):
    '''
    interno_relacao : CARDINALIDADE TIPOS_RELACAO ASPAS VARIAVEL ASPAS TIPOS_RELACAO CARDINALIDADE
                    | CARDINALIDADE TIPOS_RELACAO TIPOS_RELACAO CARDINALIDADE
                    | TIPOS_RELACAO TIPOS_RELACAO
    '''
    if len(p) == 5:
        p[0] = '\"' + p[1] + '\" ' + p[2] + ' \"' + p[3] + '\"' 
    elif len(p)==3:
        p[0] = p[1]+p[2]
    else:
        p[0] = '\"' + p[1] + '\" ' + p[2] + p[6] + ' \"' + p[7] + '\"'  
        






        
    
def p_def_iniClasses(p):
    'iniClasses : MENORQ MENORQ PALAVRA_CLASSES classes MAIORQ MAIORQ'
    p[0]= p[4]
    
def p_def_classes(p):
    '''classes : classe
    | classes classe'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1] + p[2]
    
def p_def_classe(p):
    'classe : VARIAVEL ABRE_PAR interno_classe FECHA_PAR PONTO_VIRGULA'
    p[0] = f"class {p[1]} {{\n{p[3]}\n}}\n"  
     
def p_interno_classe(p):
    '''
    interno_classe : atributos metodos_opt
                   | metodos
                   | empty
    '''
    if len(p) == 3:
        p[0] = p[1] + '\n' + p[2] if p[2] else p[1]  
    elif len(p) == 2:
        p[0] = p[1]  
    else:
        p[0] = ''    

def p_metodos_opt(p):
    '''
    metodos_opt : RETA metodos
                | empty
    '''
    if len(p) == 3:
        p[0] = p[2]  
    else:
        p[0] = ''    

def p_empty(p):
    'empty :'
    pass

def p_def_metodos(p):
    '''metodos : metodo
    | metodos metodo'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1] + '\n' + p[2]

def p_def_metodo(p):
    '''metodo : PRIVACIDADE VARIAVEL ABRE_PAR FECHA_PAR PONTO_VIRGULA
              | PRIVACIDADE VARIAVEL ABRE_PAR VARIAVEL FECHA_PAR PONTO_VIRGULA'''
    if len(p)==6:
        p[0] = f"{p[1]}{p[2]}();\n"
    else:
        p[0] = f"{p[1]}{p[2]}({p[4]});\n" 

def p_def_atributos(p):
    '''atributos : atributo
    | atributos atributo'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1] + '\n' + p[2]
    
def p_def_atributo(p):
    '''atributo : PRIVACIDADE TIPO DOIS_PONTOS VARIAVEL PONTO_VIRGULA
                | PRIVACIDADE LIST MENORQ VARIAVEL MAIORQ DOIS_PONTOS VARIAVEL PONTO_VIRGULA'''
    if len(p)==6:
        p[0] = f"{p[1]}{p[2]} {p[4]};\n"
    else:
        p[0] = f"{p[1]}List< {p[4]} > {p[7]};\n" 
    
        
def p_error(p):
    
    print("ERRO: '%s'" %p)
    print("Syntax error at '%s'" % p.value)
    
    
import ply.yacc as yacc
parser = yacc.yacc()
import sys
if len(sys.argv) < 2 :
    sys.exit("Usage: %s <filename>" % sys.argv[0])
fp = open(sys.argv[1])
contents=fp.read()

result=parser.parse(contents) 
