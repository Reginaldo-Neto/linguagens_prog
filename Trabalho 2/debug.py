import ply.lex as lex

tokens = ('CARD_ZERO_VARIOS',)

t_CARD_ZERO_VARIOS = r'0\*'

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

lexer = lex.lex()

# Teste o lexer
data = '0* aqui 0* ali 1*'
lexer.input(data)

for tok in lexer:
    print(tok)
