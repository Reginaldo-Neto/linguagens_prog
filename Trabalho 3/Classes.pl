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

insert_relation_interactive :-
    write('Enter the source class name: '), read_line_to_string(user_input, SOURCERAW),
    strip_string(SOURCERAW, SOURCE),
    display_relation_types,
    write('Enter the left-hand relation type (choose from above): '), read_line_to_string(user_input, LEFTTYPE),
    display_link_types,
    write('Enter the link type (choose from above): '), read_line_to_string(user_input, LINKTYPE),
    write('Enter the right-hand relation type (choose from above): '), read_line_to_string(user_input, RIGHTTYPE),
    write('Enter the target class name: '), read_line_to_string(user_input, TARGETRAW),
    strip_string(TARGETRAW, TARGET),
    validate_and_insert_relation(SOURCE, LEFTTYPE, LINKTYPE, RIGHTTYPE, TARGET).

strip_string(STRING, STRIPPED) :-
    string_concat(TRIMMED, " ", STRING), !,
    strip_string(TRIMMED, STRIPPED).
strip_string(STRIPPED, STRIPPED).

display_relation_types :-
    nl, write('Relation Types:'), nl,
    write('[<|] Inheritance'), nl,
    write('[*] Composition'), nl,
    write('[o] Aggregation'), nl,
    write('[>] Association'), nl,
    write('[<] Association'), nl,
    write('[|>] Realization'), nl, nl.

display_link_types :-
    nl, write('Link Types:'), nl,
    write('[--] Solid'), nl,
    write('[".."] Dashed'), nl, nl.

validate_and_insert_relation(SOURCE, LEFTTYPE, LINKTYPE, RIGHTTYPE, TARGET) :-
    class_exists(SOURCE), class_exists(TARGET),
    format_relation(LEFTTYPE, LINKTYPE, RIGHTTYPE, SYMBOL),
    retractall(relation(SOURCE, SYMBOL, TARGET)),  % Remove existing relation to avoid duplicates
    assert(relation(SOURCE, SYMBOL, TARGET)),
    write('Relation inserted successfully.'), nl.

class_exists(CLASSNAME) :-
    class(CLASSNAME, _, _).

format_relation(LEFTTYPE, LINKTYPE, RIGHTTYPE, SYMBOL) :-
    string_concat(LEFTTYPE, LINKTYPE, TEMPSYMBOL),
    string_concat(TEMPSYMBOL, RIGHTTYPE, SYMBOL).

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
    format(atom(CODE), '~w ~s ~w', [SOURCE, SYMBOL, TARGET]).
