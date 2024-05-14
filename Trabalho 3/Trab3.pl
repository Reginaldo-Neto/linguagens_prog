:- dynamic class/4.

% class(ClassName, Attributes, Operations, Relations).
insert_class(Name, Attributes, Operations, Relations) :-
    retractall(class(Name, _, _, _)),  % Remove existing definition if any
    assert(class(Name, Attributes, Operations, Relations)).
valid_relation((Type, OtherClass)) :-
    class(OtherClass, _, _, _),
    member(Type, [association, inheritance, aggregation, composition]).

valid_relations([]).
valid_relations([R|Rs]) :-
    valid_relation(R),
    valid_relations(Rs).
count_attributes(ClassName, Count) :-
    class(ClassName, Attributes, _, _),
    length(Attributes, Count).
generate_mermaid :-
    findall(Code, mermaid_class_code(Code), Codes),
    findall(RelationCode, mermaid_relation_code(RelationCode), RelationCodes),
    write('classDiagram'), nl,
    maplist(write_and_nl, Codes),
    maplist(write_and_nl, RelationCodes).

    mermaid_class_code(Code) :-
        class(Name, Attributes, Operations, _),
        atomics_to_string(["class ", Name, " {"], ClassHeader),
        (Attributes \= [] -> atomics_to_string(Attributes, "\n", AttrStr); AttrStr = ""),
        (Operations \= [] -> atomics_to_string(Operations, "\n", OpStr); OpStr = ""),
        (Attributes \= [] ; Operations \= [] -> 
            atomics_to_string(["}\n", AttrStr, "\n", OpStr], ClassBody)
        ;   ClassBody = ""),
        atomics_to_string([ClassHeader, ClassBody, "}"], Code).
    
mermaid_relation_code(Code) :-
    class(Name, _, _, Relations),
    member((Type, OtherClass), Relations),
    relation_symbol(Type, Symbol),
    format(atom(Code), '~w ~s ~w', [Name, Symbol, OtherClass]).

relation_symbol(association, "--").
relation_symbol(inheritance, "--|>").
relation_symbol(aggregation, "--o").
relation_symbol(composition, "--*").

write_and_nl(Line) :- write(Line), nl.
