# TITULO: IPB
# DIAGRAMA GERAL:
# <<RELACOES		
#     Course (0* --o 1) School;
#     Course (1 o-- 0*) Subject;
#     Student (1 -"attends"- 0*) Course;
#     Subject (0*-- ) Grade ( -- 0*) Student;
#     Teacher (0* --"teaches"--1) Subject;
#     person (<|--) Teacher;
#     person (<|--) Student;
#     School (1 *--> 1*) Teacher;
# >>
# <<CLASSES
#     School(
#         PRI STRING: name;
#         PRI LIST<Course>: coursesCollection;
#         PRI LIST<Teacher>: teachersCollection;
#         |
#         PUB addCourse(); 
#         PUB addTeacher();
#     );
#     Course(
#         PRI STRING: name;
#         PRI LIST<Student>: studentsCollection;
#         PRI LIST<Subject>: subjectsCollection;
#     );
#     Grade(
#         PRI INT: value, subject_code, student_number;
#         |
#         PUB INT: getValue();
#         PUB VOID: setValue();
#     );
#     Teacher(
#         PRI LIST<Subject>: subjectCollection;
#     );
#     Student(
#         PRI INT: number;
#         PRI STRING: course_name;
#         PRI LIST<Grade>: gradesCollection;
#         );
#     Subject(
#         PRI STRING: name, course_name, teacher_name;
#         PRI INT: code;
#         PRI LIST<Grade>: gradesCollection;
#     );
#     person(
#         PRI STRING: name;
#     );
# >>

tokens = (
    'TITULO', 'VARIAVEL', 'DIAGRAMA', 'CLASSES', 'RELACOES',
    'VIRGULA', 'ABRE_PAR', 'FECHA_PAR', 'RETA', 'MAIORQ', 'MENORQ', 'DOIS_PONTOS', 'PONTO_VIRGULA',
    #'INT', 'FLOAT', 'LIST', 'VOID', 'STRING', 
    'TIPO', 'PRIVACIDADE',
    #'PUB', 'PRI', 'PRO', 'PAC', 
    'CARD_UM', 'CARD_VARIOS', 'CARD_ZERO_UM', 'CARD_ZERO_VARIOS', 'CARD_UM_VARIOS',
    'REL_SOLIDA', 'REL_TRACEJADA', 
    'REL_HERANCA_ESQ', 'REL_HERANCA_DIR',
    'REL_COMPOSICAO_ESQ', 'REL_COMPOSICAO_DIR', 
    'REL_AGREGRACAO_ESQ', 'REL_AGREGACAO_DIR',
    'REL_ASSOCIACAO_ESQ', 'REL_ASSOCIACAO_DIR', 
    'REL_DEPENDENCIA_ESQ', 'REL_DEPENDENCIA_DIR',
    'REL_REALIZACAO_ESQ', 'REL_REALIZACAO_DIR', 
)
literals = ",();><|-*"

#AS PALAVRAS RESERVADAS DEVEM SER FEITAS PRIMEIRO
def t_TITULO(t): 
    r'TITULO'
    return t

def t_DIAGRAMA(t): 
    r'DIAGRAMA GERAL'
    return t

def t_TIPO(t): 
    r'INT|FLOAT|STRING|LIST|VOID'
    return t

# def t_INT(t): 
#     r'INT'
#     return t

# def t_FLOAT(t): 
#     r'FLOAT'
#     return t

# def t_STRING(t): 
#     r'STRING'
#     return t

# def t_VOID(t): 
#     r'VOID'
#     return t

# def t_LIST(t): 
#     r'LIST'
#     return t

def t_PRIVACIDADE(t): 
    r'PUB|PRI|PAC|PRO'
    return t

# def t_PUB(t): 
#     r'PUB'
#     return t

# def t_PRI(t): 
#     r'PRI'
#     return t

# def t_PRO(t): 
#     r'PRO'
#     return t

# def t_PAC(t): 
#     r'PAC'
#     return t

def t_CLASSES(t): 
    r'CLASSES'
    return t

def t_RELACOES(t): 
    r'RELACOES'
    return t

def t_CARD_UM_VARIOS(t): 
    r'1\*'
    return t

t_CARD_ZERO_VARIOS = r'0\*'

def t_CARD_ZERO_UM(t): 
    r'01'
    return t

def t_CARD_UM(t): 
    r'1'
    return t

t_CARD_VARIOS = r'\*'

def t_REL_HERANCA_ESQ(t):
    r'<|\-'
    return t

def t_REL_HERANCA_DIR(t):
    r'\-|>'
    return t

t_REL_COMPOSICAO_ESQ = r'\*\-'

t_REL_COMPOSICAO_DIR = r'\-\*'

def t_REL_AGREGACAO_ESQ(t):
    r'o-'
    return t

def t_REL_AGREGACAO_DIR(t):
    r'-o'
    return t

def t_REL_ASSOCIACAO_ESQ(t):
    r'<-'
    return t

def t_REL_ASSOCIACAO_DIR(t):
    r'->'
    return t

def t_REL_DEPENDENCIA_ESQ(t):
    r'<.'
    return t

def t_REL_DEPENDENCIA_DIR(t):
    r'.>'
    return t

def t_REL_REALIZACAO_ESQ(t):
    r'<|.'
    return t

def t_REL_REALIZACAO_DIR(t):
    r'.|>'
    return t

def t_REL_SOLIDA(t):
    r'-'
    return t

def t_REL_TRACEJADA(t):
    r'.'
    return t

def t_VARIAVEL(t):
    r'[a-zA-Z_]+'
    return t

t_DOIS_PONTOS = r':'
t_PONTO_VIRGULA = r'\;'
t_RETA = r'\|'
t_MAIORQ = r'\>'
t_MENORQ = r'\<'
t_VIRGULA = r'\,'
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
# Expansão das regras de análise sintática

def p_def_program(p):
    'program : comeco iniClasses relacoes'
    p[0] = f"{p[1]}"
    
def p_def_comeco(p):
    'comeco : TITULO DOIS_PONTOS VARIAVEL DIAGRAMA DOIS_PONTOS'
    p[0] = f"%%{p[1]}{p[2]}{p[3]}\nclassDiagram\n\t"

def p_def_iniClasses(p):
    'iniClasses : MENORQ MENORQ classes MAIORQ MAIORQ'
    p[0]= p[3]
    
def p_def_classes(p):
    '''classes : classe
    | classes classe'''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1] + p[2]
    
def p_def_classe(p):
    'classe : VARIAVEL ABRE_PAR interno_classe FECHA_PAR PONTO_VIRGULA'
    p[0] = f"class {p[1]}","{",f"{p[3]}","}" 
    #TA ERRADO, PRECISO RETORNAR O NOME DA CLASSE JUNTO COM OS ATRIBUTOS E METODOS
    
def p_def_interno_classe(p):
    '''interno_classe : atributos
    | interno_classe metodos
    | interno_classe atributos RETA metodos'''
    
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[1] + p[2]

def p_error(p):
    print("Syntax error at '%s'" % p.value)
    
    
import ply.yacc as yacc
parser = yacc.yacc()
import sys
if len(sys.argv) < 2 :
    sys.exit("Usage: %s <filename>" % sys.argv[0])
fp = open(sys.argv[1])
contents=fp.read()

result=parser.parse(contents) 
#print("digraph{")
#print("}")


#Ao inves da linha 47 e 49, é possivel tem statements vazios

# def p_def_def(t):
#   'def: begin relacoes end'

#def begin(t):
#   'begin : '
#    print("digraph{")

#def end(t):
#   'end : '
#    print("}")