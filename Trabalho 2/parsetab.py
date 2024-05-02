
# parsetab.py
# This file is automatically generated. Do not edit.
# pylint: disable=W,C,R
_tabversion = '3.10'

_lr_method = 'LALR'

_lr_signature = 'ABRE_PAR ASPAS CARDINALIDADE DIAGRAMA DOIS_PONTOS FECHA_PAR GERAL LIST MAIORQ MENORQ PALAVRA_CLASSES PALAVRA_RELACOES PONTO_VIRGULA PRIVACIDADE RETA TIPO TIPOS_RELACAO TITULO VARIAVELprogram : comeco iniRelacoes iniClassescomeco : TITULO DOIS_PONTOS VARIAVEL DIAGRAMA GERAL DOIS_PONTOSiniRelacoes : MENORQ MENORQ PALAVRA_RELACOES relacoes MAIORQ MAIORQrelacoes : relacao\n    | relacoes relacaorelacao : VARIAVEL ABRE_PAR interno_relacao FECHA_PAR VARIAVEL PONTO_VIRGULA\n    interno_relacao : CARDINALIDADE TIPOS_RELACAO ASPAS VARIAVEL ASPAS TIPOS_RELACAO CARDINALIDADE\n                    | CARDINALIDADE TIPOS_RELACAO TIPOS_RELACAO CARDINALIDADE\n                    | TIPOS_RELACAO TIPOS_RELACAO\n    iniClasses : MENORQ MENORQ PALAVRA_CLASSES classes MAIORQ MAIORQclasses : classe\n    | classes classeclasse : VARIAVEL ABRE_PAR interno_classe FECHA_PAR PONTO_VIRGULA\n    interno_classe : atributos metodos_opt\n                   | metodos\n                   | empty\n    \n    metodos_opt : RETA metodos\n                | empty\n    empty :metodos : metodo\n    | metodos metodometodo : PRIVACIDADE VARIAVEL ABRE_PAR FECHA_PAR PONTO_VIRGULA\n              | PRIVACIDADE VARIAVEL ABRE_PAR VARIAVEL FECHA_PAR PONTO_VIRGULAatributos : atributo\n    | atributos atributoatributo : PRIVACIDADE TIPO DOIS_PONTOS VARIAVEL PONTO_VIRGULA\n                | PRIVACIDADE LIST MENORQ VARIAVEL MAIORQ DOIS_PONTOS VARIAVEL PONTO_VIRGULA'
    
_lr_action_items = {'TITULO':([0,],[3,]),'$end':([1,7,33,],[0,-1,-10,]),'MENORQ':([2,4,5,8,25,29,54,],[5,8,9,11,-2,-3,62,]),'DOIS_PONTOS':([3,18,52,74,],[6,25,60,77,]),'VARIAVEL':([6,12,14,15,16,19,20,23,27,40,41,51,57,58,60,61,62,63,77,],[10,17,21,17,-4,21,-11,-5,-12,53,55,53,65,-13,66,67,69,-6,79,]),'PALAVRA_RELACOES':([9,],[12,]),'DIAGRAMA':([10,],[13,]),'PALAVRA_CLASSES':([11,],[14,]),'GERAL':([13,],[18,]),'MAIORQ':([15,16,19,20,22,23,26,27,58,63,69,],[22,-4,26,-11,29,-5,33,-12,-13,-6,74,]),'ABRE_PAR':([17,21,53,],[24,28,61,]),'CARDINALIDADE':([24,56,75,],[31,64,78,]),'TIPOS_RELACAO':([24,31,32,42,70,],[32,42,43,56,75,]),'FECHA_PAR':([28,30,34,35,36,37,38,39,43,45,46,48,50,59,61,64,67,71,73,76,78,80,],[-19,41,44,-19,-15,-16,-24,-20,-9,-14,-25,-18,-21,-17,68,-8,72,-26,-22,-23,-7,-27,]),'PRIVACIDADE':([28,35,36,38,39,46,47,50,59,71,73,76,80,],[40,49,51,-24,-20,-25,51,-21,51,-26,-22,-23,-27,]),'RETA':([35,38,46,71,80,],[47,-24,-25,-26,-27,]),'TIPO':([40,49,],[52,52,]),'LIST':([40,49,],[54,54,]),'ASPAS':([42,65,],[57,70,]),'PONTO_VIRGULA':([44,55,66,68,72,79,],[58,63,71,73,76,80,]),}

_lr_action = {}
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = {}
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'program':([0,],[1,]),'comeco':([0,],[2,]),'iniRelacoes':([2,],[4,]),'iniClasses':([4,],[7,]),'relacoes':([12,],[15,]),'relacao':([12,15,],[16,23,]),'classes':([14,],[19,]),'classe':([14,19,],[20,27,]),'interno_relacao':([24,],[30,]),'interno_classe':([28,],[34,]),'atributos':([28,],[35,]),'metodos':([28,47,],[36,59,]),'empty':([28,35,],[37,48,]),'atributo':([28,35,],[38,46,]),'metodo':([28,36,47,59,],[39,50,39,50,]),'metodos_opt':([35,],[45,]),}

_lr_goto = {}
for _k, _v in _lr_goto_items.items():
   for _x, _y in zip(_v[0], _v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = {}
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> program","S'",1,None,None,None),
  ('program -> comeco iniRelacoes iniClasses','program',3,'p_def_program','sagui_parser.py',232),
  ('comeco -> TITULO DOIS_PONTOS VARIAVEL DIAGRAMA GERAL DOIS_PONTOS','comeco',6,'p_def_comeco','sagui_parser.py',237),
  ('iniRelacoes -> MENORQ MENORQ PALAVRA_RELACOES relacoes MAIORQ MAIORQ','iniRelacoes',6,'p_def_iniRelacoes','sagui_parser.py',241),
  ('relacoes -> relacao','relacoes',1,'p_def_relacoes','sagui_parser.py',245),
  ('relacoes -> relacoes relacao','relacoes',2,'p_def_relacoes','sagui_parser.py',246),
  ('relacao -> VARIAVEL ABRE_PAR interno_relacao FECHA_PAR VARIAVEL PONTO_VIRGULA','relacao',6,'p_def_relacao','sagui_parser.py',253),
  ('interno_relacao -> CARDINALIDADE TIPOS_RELACAO ASPAS VARIAVEL ASPAS TIPOS_RELACAO CARDINALIDADE','interno_relacao',7,'p_interno_relacao','sagui_parser.py',258),
  ('interno_relacao -> CARDINALIDADE TIPOS_RELACAO TIPOS_RELACAO CARDINALIDADE','interno_relacao',4,'p_interno_relacao','sagui_parser.py',259),
  ('interno_relacao -> TIPOS_RELACAO TIPOS_RELACAO','interno_relacao',2,'p_interno_relacao','sagui_parser.py',260),
  ('iniClasses -> MENORQ MENORQ PALAVRA_CLASSES classes MAIORQ MAIORQ','iniClasses',6,'p_def_iniClasses','sagui_parser.py',278),
  ('classes -> classe','classes',1,'p_def_classes','sagui_parser.py',282),
  ('classes -> classes classe','classes',2,'p_def_classes','sagui_parser.py',283),
  ('classe -> VARIAVEL ABRE_PAR interno_classe FECHA_PAR PONTO_VIRGULA','classe',5,'p_def_classe','sagui_parser.py',290),
  ('interno_classe -> atributos metodos_opt','interno_classe',2,'p_interno_classe','sagui_parser.py',295),
  ('interno_classe -> metodos','interno_classe',1,'p_interno_classe','sagui_parser.py',296),
  ('interno_classe -> empty','interno_classe',1,'p_interno_classe','sagui_parser.py',297),
  ('metodos_opt -> RETA metodos','metodos_opt',2,'p_metodos_opt','sagui_parser.py',308),
  ('metodos_opt -> empty','metodos_opt',1,'p_metodos_opt','sagui_parser.py',309),
  ('empty -> <empty>','empty',0,'p_empty','sagui_parser.py',317),
  ('metodos -> metodo','metodos',1,'p_def_metodos','sagui_parser.py',321),
  ('metodos -> metodos metodo','metodos',2,'p_def_metodos','sagui_parser.py',322),
  ('metodo -> PRIVACIDADE VARIAVEL ABRE_PAR FECHA_PAR PONTO_VIRGULA','metodo',5,'p_def_metodo','sagui_parser.py',329),
  ('metodo -> PRIVACIDADE VARIAVEL ABRE_PAR VARIAVEL FECHA_PAR PONTO_VIRGULA','metodo',6,'p_def_metodo','sagui_parser.py',330),
  ('atributos -> atributo','atributos',1,'p_def_atributos','sagui_parser.py',337),
  ('atributos -> atributos atributo','atributos',2,'p_def_atributos','sagui_parser.py',338),
  ('atributo -> PRIVACIDADE TIPO DOIS_PONTOS VARIAVEL PONTO_VIRGULA','atributo',5,'p_def_atributo','sagui_parser.py',345),
  ('atributo -> PRIVACIDADE LIST MENORQ VARIAVEL MAIORQ DOIS_PONTOS VARIAVEL PONTO_VIRGULA','atributo',8,'p_def_atributo','sagui_parser.py',346),
]
