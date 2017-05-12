%
% @file medical-expert-system.pl
% @author Paul Malayrevich <paul.malyarevich@gmail.com>
% @version 1.0
%
% Init
go:- hypothesis(I),
    write('Most likely you are sick: '),
    write(I),
    nl,
    undo.

% Tests for hypothesis
hypothesis(commoncold):- commoncold, !.
hypothesis(flu):- flu, !.
hypothesis(angina):- angina, !.
hypothesis(sinusitis):- sinusitis, !.
hypothesis(pneumonia):- pneumonia, !.
hypothesis(pigflu):- pigflu, !.
hypothesis(unknown). /* Not one of the above */

% Illness
commoncold :-
       symptom(headaches),
       symptom(noserunning),
       symptom(sneezing),
       symptom(throatpain).
flu :-
       symptom(fever),
       symptom(headaches),
       symptom(chills),
       symptom(bodyaches).
angina :-
       symptom(cough),
       symptom(fever),
       symptom(nausea),
       symptom(throatpain).
sinusitis :-
       symptom(nausea),
       symptom(noserunning),
       symptom(headaches),
       symptom(sneezing),
       symptom(eyespain).
pneumonia :-
       symptom(cough),
       symptom(nausea),
       symptom(fever),
       symptom(bodyaches).
pigflu :-
       symptom(cough),
       symptom(noserunning),
       symptom(nausea),
       symptom(bodyaches).

% Functions
ask(Q) :-
    write('Does the patient have the following symptom: '),
    write(Q),
    write('? '),
    readln(A),
    nl,
    ( (A == [yes] ; A == [y])
      ->
       assert(yes(Q)) ;
       assert(no(Q)), fail).

:- dynamic yes/1,no/1.

symptom(S) :- (yes(S) -> true ;
               (no(S)  -> fail ;
               ask(S))).

% For session
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
