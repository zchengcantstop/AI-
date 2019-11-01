%fact
male('Philip').
male('Charles').
male('Mark').
male('Andrew').
male('Edward').
male('William').
male('Peter').
male('James').
male('George').
male('Harry').
male('Margaret').
male('Spencer').
female('Elizabeth').
female('Mum').
female('Diana').
female('Kydd').
female('Anne').
female('Sarah').
female('Sophie').
female('Zara').
female('Beatrice').
female('Eugenie').
female('Louise').

child('Elizabeth','George').
child('Elizabeth','Mum').
child('Margaret','George').
child('Margaret','Mum').
child('Charles','Elizabeth').
child('Charles','Philip').
child('Anne','Elizabeth').
child('Anne','Philip').
child('Andrew','Elizabeth').
child('Andrew','Philip').
child('Edward','Elizabeth').
child('Edward','Philip').
child('William','Diana').
child('William','Charles').
child('Harry','Diana').
child('Harry','Charles').
child('Peter','Anne').
child('Peter','Mark').
child('Zara','Anne').
child('Zara','Mark').
child('Beatrice','Andrew').
child('Beatrice','Sarah').
child('Eugenie','Andrew').
child('Eugenie','Sarah').
child('Louise','Edward').
child('Louise','Sophie').
child('James','Edward').
child('James','Sophie').
child('Diana','Kydd').
child('Diana','Spencer').

couple('George','Mum').
couple('Mum','George').
couple('Spencer','Kydd').
couple('Kydd','Spencer').
couple('Elizabeth','Philip').
couple('Philip','Elizabeth').
couple('Andrew','Sarah').
couple('Sarah','Andrew').
couple('Edward','Sophie').
couple('Sophie','Edward').
couple('Diana','Charles').
couple('Charles','Diana').
couple('Mark','Anne').
couple('Anne','Mark').

sible('Elizabeth','Margaret').
sible('Charles','Anne').
sible('Charles','Andrew').
sible('Charles','Edward').
sible('Anne','Andrew').
sible('Anne','Edward').
sible('Andrew','Edward').
sible('William','Harry').
sible('Harry','Zara').
sible('Beatrice','Eugenie').
sible('Louise','James').
sibling(X,Y):-sible(X,Y).
sibling(X,Y):-sible(Y,X).


%precidate

grandchild(X,Y):-child(X,Z),child(Z,Y).
greatgrandparent(X,Y):-child(Y,A),child(A,B),child(B,X).
ancestor(X,Y):-child(Y,X).
ancestor(X,Y):-child(Z,X),ancestor(Z,Y).
brother(X,Y):-sibling(X,Y),male(X).
sister(X,Y):-sibling(X,Y),female(X).
daughter(X,Y):-child(X,Y),female(X).
son(X,Y):-child(X,Y),male(X).
firstCousion(X,Y):-child(X,A),child(Y,B),sibling(A,B).
brotherInLaw(X,Y):-brother(X,Z),couple(Z,Y).
sisterInLaw(X,Y):-sister(X,Z),couple(Z,Y).
aunt(X,Y):-sister(X,Z),child(Z,Y).
aunt(X,Y):-sisterInLaw(X,Z),child(Z,Y).
uncle(X,Y):-brother(X,Z),child(Y,Z).
uncle(X,Y):-brotherInLaw(X,Z),child(Y,Z).


%mth cousin nth generation
dis(X,X,0).
dis(X,Y,N):-child(X,Z),dis(Z,Y,N1),N1 is N-1.
mcousinngeneration(X,Y,M,N):-dis(X,Z,M+1),dis(Y,Z,M+N+1).


/***query
1.grandchild(X,'Elizabeth'),write(X),nl,fail.
2.brotherInLaw(X,'Diana'),write(X),nl,fail.
3.greatgrandparent(X,'Zara'),write(X),nl,fail.
4.ancestor(X,'Eugenie'),write(X),nl,fail.
***/




