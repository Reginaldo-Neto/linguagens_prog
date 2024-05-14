:- dynamic class/4.

% Predicados para armazenar classes
% class(ClassName, Attributes, Operations, Relations).
% Attributes as list of (Type, Name) pairs.
% Operations as list of OperationName.
% Relations as list of (RelationType, OtherClass).

% Inicialização e menu principal
init :- menu.
init2 :- consult('classes.pl'), menu.
menu :- repeat,
        write('1 - List Classes'), nl,
        write('2 - Insert Class'), nl,
        write('3 - Insert Relation'), nl,
        write('4 - Count Attributes'), nl,
        write('5 - Generate Mermaid Diagram'), nl,
        write('0 - Exit'), nl,
        read(Choice), 
        do_action(Choice),
        Choice == 0.

do_action(1) :- list_classes, nl.
do_action(2) :- insert_class_interactive, nl.
do_action(3) :- insert_relation_interactive, nl.
do_action(4) :- count_attributes_interactive, nl.
do_action(5) :- generate_mermaid, nl.
do_action(0) :- write('Exiting...'), nl.
do_action(_) :- write('Invalid option, please try again.'), nl.

% Listar todas as classes
list_classes :-
    class(Name, Attributes, Operations, Relations),
    write('Class Name: '), write(Name), nl,
    write('Attributes: '), write(Attributes), nl,
    write('Operations: '), write(Operations), nl,
    write('Relations: '), write(Relations), nl, nl,
    fail.
list_classes.

% Inserir classes interativamente
insert_class_interactive :-
    write('Enter class name: '), read(Name),
    write('Enter attributes as pairs (type name): '), read(Attributes),
    write('Enter operations: '), read(Operations),
    write('Enter relations as pairs (type class): '), read(Relations),
    insert_class(Name, Attributes, Operations, Relations).

insert_class(Name, Attributes, Operations, Relations) :-
    retractall(class(Name, _, _, _)),
    assert(class(Name, Attributes, Operations, Relations)).

% Inserir relações interativamente
insert_relation_interactive :-
    write('Enter the source class name: '), read(Source),
    write('Enter the relation type: '), read(Type),
    write('Enter the target class name: '), read(Target),
    (class(Source, _, _, _), class(Target, _, _, _) ->
        assert_relation(Source, Type, Target)
    ;   write('One or both classes do not exist.'), nl).

assert_relation(Source, Type, Target) :-
    retract(class(Source, Attrs, Ops, Rels)),
    assert(class(Source, Attrs, Ops, [(Type, Target)|Rels])).

% Contar atributos de uma classe
count_attributes_interactive :-
    write('Enter class name to count its attributes: '), read(Name),
    (class(Name, Attributes, _, _) ->
        length(Attributes, Count),
        write('Number of attributes: '), write(Count), nl
    ;   write('Class not found.'), nl).

% Gerar código Mermaid
generate_mermaid :-
    findall(Code, mermaid_class_code(Code), Codes),
    findall(RelationCode, mermaid_relation_code(RelationCode), RelationCodes),
    write('classDiagram'), nl,
    maplist(write, Codes),
    maplist(write, RelationCodes).

mermaid_class_code(Code) :-
    class(Name, Attributes, Operations, _),
    format(atom(ClassHeader), 'class ~w {~n', [Name]),
    findall(AttrLine, (member((Type, Attr), Attributes), format(atom(AttrLine), '  +~w : ~w~n', [Attr, Type])), AttrLines),
    atomic_list_concat(AttrLines, '', AttrsStr),
    findall(OpLine, (member(Op, Operations), format(atom(OpLine), '  +~w()~n', [Op])), OpLines),
    atomic_list_concat(OpLines, '', OpsStr),
    format(atom(Code), '~w~w~w}~n', [ClassHeader, AttrsStr, OpsStr]).

mermaid_relation_code(Code) :-
    class(Name, _, _, Relations),
    member((Type, OtherClass), Relations),
    relation_symbol(Type, Symbol),
    format(atom(Code), '~w ~s ~w~n', [Name, Symbol, OtherClass]).

relation_symbol(association, "--").
relation_symbol(inheritance, "--|>").
relation_symbol(aggregation, "--o").
relation_symbol(composition, "--*").

% Save to file
save :- tell('classes.pl'),
    listing(class),
    told.
