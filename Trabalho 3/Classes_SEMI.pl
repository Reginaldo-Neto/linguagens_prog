:- dynamic class/3.  % class(CLASSNAME, ATTRIBUTES, OPERATIONS).
:- dynamic relation/3.  % relation(SOURCECLASS, SYMBOL, TARGETCLASS).

% Inicialização e menu principal
init :- menu.
init2 :- consult('classes.pl'), menu.

menu :-
    repeat,
    menu_options,
    read(CHOICE),
    (   valid_option(CHOICE)
    ->  do_action(CHOICE),
        CHOICE == 0
    ;   write('Invalid option, please try again.'), nl, fail
    ).

menu_options :-
    write('1 - List Classes'), nl,
    write('2 - Insert Class'), nl,
    write('3 - Insert Relation'), nl,
    write('4 - Count Attributes'), nl,
    write('5 - Generate Mermaid Diagram'), nl,
    write('0 - Exit'), nl.

valid_option(0).
valid_option(1).
valid_option(2).
valid_option(3).
valid_option(4).
valid_option(5).

do_action(0) :- write('Exiting...'), nl.
do_action(1) :- list_classes, nl.
do_action(2) :- insert_class_interactive, nl.
do_action(3) :- insert_relation_interactive, nl.
do_action(4) :- count_attributes_interactive, nl.
do_action(5) :- generate_mermaid, nl.

list_classes :-
    class(NAME, ATTRIBUTES, OPERATIONS),
    write('Class Name: '), write(NAME), nl,
    write('Attributes: '), write(ATTRIBUTES), nl,
    write('Operations: '), write(OPERATIONS), nl, nl,
    fail.
list_classes.

insert_class_interactive :-
    read_line_to_string(user_input, _),
    write('Enter class name: '), read(NAME),
    write('Enter attributes as pairs [(Type, Name), ...]: '), read(ATTRIBUTES),
    write('Enter operations [op1(), op2(), ...]: '), read(OPERATIONS),
    insert_class(NAME, ATTRIBUTES, OPERATIONS).

insert_class(NAME, ATTRIBUTES, OPERATIONS) :-
    retractall(class(NAME, _, _)),
    assert(class(NAME, ATTRIBUTES, OPERATIONS)).

% Predicado principal interativo para inserção de relações
insert_relation_interactive :-
    read_line_to_string(user_input, _),
    write('Enter the source class name: '), read(SOURCE),
    display_relation_types,
    write('Enter the left-hand relation type (choose from above): '), read(ESQREL),
    get_rel_type(ESQREL, LEFTTYPE),
    display_link_types,
    write('Enter the link type (choose from above): '), read(LINK),
    get_link_type(LINK, LINKTYPE),
    display_relation_types,
    write('Enter the right-hand relation type (choose from above): '), read(DIRREL),
    get_rel_type(DIRREL, RIGHTTYPE),
    write('Enter the target class name: '), read(TARGET),
    validate_and_insert_relation(SOURCE, LEFTTYPE, LINKTYPE, RIGHTTYPE, TARGET).

% Display available relation types
display_relation_types :-
    nl, write('Relation Types:'), nl,
    write('0 - [] Empty'), nl,
    write('1 - [*] Composition'), nl,
    write('2 - [o] Aggregation'), nl,
    write('3 - [>] Association'), nl,
    write('4 - [<] Association'), nl,
    write('5 - [|>] Realization'), nl,
    write('6 - [<|] Inheritance'), nl, nl.

% Display available link types
display_link_types :-
    nl, write('Link Types:'), nl,
    write('1 - [--] Solid'), nl,
    write('2 - [..] Dashed'), nl, nl.

% Retrieves the symbolic representation of the relation type based on an index
get_rel_type(Index, Symbol) :-
    nth0(Index, ['', '*', 'o', '>', '<', '|>', '<|'], Symbol).

% Retrieves the symbolic representation of the link type based on an index
get_link_type(Index, Symbol) :-
    nth0(Index, ['', '--', '..'], Symbol).

% Validation and insertion of the relation
validate_and_insert_relation(SOURCE, LEFTTYPE, LINKTYPE, RIGHTTYPE, TARGET) :-
    class_exists(SOURCE), class_exists(TARGET),
    format_relation(LEFTTYPE, LINKTYPE, RIGHTTYPE, SYMBOL),
    retractall(relation(SOURCE, SYMBOL, TARGET)),  % Remove existing relations to avoid duplicates
    assert(relation(SOURCE, SYMBOL, TARGET)),
    write('Relation inserted successfully.'), nl.

% Check if class exists
class_exists(CLASSNAME) :-
    class(CLASSNAME, _, _).

% Format the complete relation symbol from components
format_relation(LEFTTYPE, LINKTYPE, RIGHTTYPE, SYMBOL) :-
    string_concat(LEFTTYPE, LINKTYPE, TEMP),
    string_concat(TEMP, RIGHTTYPE, SYMBOL).


count_attributes_interactive :-
    read_line_to_string(user_input, _),
    write('Enter class name to count its attributes: '), read(NAME),
    (   class(NAME, ATTRIBUTES, _)
    ->  length(ATTRIBUTES, COUNT),
        write('Number of attributes: '), write(COUNT), nl
    ;   write('Class not found.'), nl).

generate_mermaid :-
    findall(CLASSCODE, mermaid_class_code(CLASSCODE), CLASSCODES),
    findall(RELATIONCODE, mermaid_relation_code(RELATIONCODE), RELATIONCODES),
    write('classDiagram'), nl,
    maplist(write, CLASSCODES),
    maplist(write, RELATIONCODES).

mermaid_class_code(CODE) :-
    class(NAME, ATTRIBUTES, OPERATIONS),
    format(atom(CLASSHEADER), 'class ~w', [NAME]),
    (   ATTRIBUTES = [], OPERATIONS = []
    ->  format(atom(CODE), '~w~n', [CLASSHEADER])  % Para classes sem atributos e operações.
    ;   findall(ATTRLINE, (member((TYPE, ATTR), ATTRIBUTES), format(atom(ATTRLINE), '  +~w : ~w~n', [TYPE, ATTR])), ATTRLINES),
        atomic_list_concat(ATTRLINES, '', ATTRSSTR),
        findall(OPLINE, (member(OP, OPERATIONS), format(atom(OPLINE), '  +~w~n', [OP])), OPLINES),
        atomic_list_concat(OPLINES, '', OPSSTR),
        format(atom(CODE), '~w {~n~w~w}~n', [CLASSHEADER, ATTRSSTR, OPSSTR])
    ).

mermaid_relation_code(CODE) :-
    relation(SOURCE, SYMBOL, TARGET),
    format(atom(CODE), '~w ~s ~w~n', [SOURCE, SYMBOL, TARGET]).
