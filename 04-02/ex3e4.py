import ply.lex as lex
tokens = ('PAL','SPACE')
def t_PAL(t):
 r'Maria'
 t.lexer.count += 1
 pass
 #print (t.value,t.lexer.count,end="")
def t_SPACE(t):
 r'.|\n'
 pass
 #print (t.value,end="")
def t_error(t):
 print("Illegal character '%s'" % t.value[0])
 t.lexer.skip(1)
lexer=lex.lex()
lexer.count=0
lexer.input("Maria is the housekeeper of Maria")
for token in lexer:
 pass
print(lexer.count)