%Declaracoes iniciaias

:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).

%Definicoes iniciais
:- op( 900,xfy,'::' ).
:- use_module(library(lists)).

:- include('pontos.pl').
:- include('arcos.pl').
:- include('estimas.pl').

%---------------------------- Declarações Iniciais --------------------------------------

garagem(0).
deposicao(1000).


adjacente(X,Y) :- arcos_indiferenciados(X,Y,_).

adjacente_lixo(X,Y) :- arcos_lixo(X,Y,_).

adjacente_papel(X,Y) :- arcos_papel(X,Y,_).

adjacente_vidro(X,Y) :- arcos_vidro(X,Y,_).

adjacente_embalagem(X,Y) :- arcos_embalagem(X,Y,_).

adjacente_organico(X,Y) :- arcos_organico(X,Y,_).

adjacenteC(X,Y,K) :- arcos_indiferenciados(X,Y,K).

adjacenteC_lixo(X,Y,K) :- arcos_lixo(X,Y,K).

adjacenteC_papel(X,Y,K) :- arcos_papel(X,Y,K).

adjacenteC_vidro(X,Y,K) :- arcos_vidro(X,Y,K).

adjacenteC_embalagem(X,Y,K) :- arcos_embalagem(X,Y,K).

adjacenteC_organico(X,Y,K) :- arcos_organico(X,Y,K).

ponto_recolha(X,Y,Z,K,E,F,B) :- ponto_recolha_lixo(X,Y,Z,K,E,F,B);ponto_recolha_papel(X,Y,Z,K,E,F,B);ponto_recolha_vidro(X,Y,Z,K,E,F,B);ponto_recolha_embalagem(X,Y,Z,K,E,F,B);ponto_recolha_organico(X,Y,Z,K,E,F,B).


%-------------------------------------- Predicados ---------------------------------------

nao( Questao ) :- Questao, !, fail.
nao( Questao ).

%Calcula o comprimento de uma lista
comprimento( [],0 ).
comprimento( [_|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.

%Predicado que da um print no terminal
print([]).
print([X|T]) :- write(X), nl, print(T).

%verifica se um elemento pertence a uma  lista
temElem([],_).
temElem(L,[H|T]):- member(H,L).
temElem(L,[H|T]):- temElem(L,T);memberchk(H,L).  

%verifica se uma lista esta vazia
estaVazia(L,V) :- comprimento(L,V),nao(V>0).

%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%------------------------------------ Caminho de um ponto de Recolha (ou garagem) para outro (ou deposicao) especificando o tipo de lixo --------------------------------------------------

getCaminho(Origem,Destino,Lixo) :-
	Lixo == "Lixo", getCaminhoLixo(Origem,Destino);
	Lixo == "Papel", getCaminhoPapel(Origem,Destino);
	Lixo == "Vidro", getCaminhoVidro(Origem,Destino);
	Lixo == "Embalagens", getCaminhoEmbalagem(Origem,Destino);
	Lixo == "Organico", getCaminhoOrganico(Origem,Destino).


getCaminhoLixo(Origem,Destino) :-
	findall((P,Dist),caminhoLixo(Origem,Destino,Dist,P),L),
	print(L).

caminhoLixo(Origem,Destino,Dist,[Origem|Percurso]) :-
	caminhoAuxLixo(Origem,Destino,Percurso,Dist,[]).

caminhoAuxLixo(Destino,Destino,[],0,_).
caminhoAuxLixo(Origem,Destino,[Proximo|Percurso],Dist,Visitados) :-
	Origem \= Destino,
	arcos_lixo(Origem,Proximo,Dist1),
	\+member(Proximo,Visitados),
	caminhoAuxLixo(Proximo,Destino,Percurso,Dist2,[Origem|Visitados]),
	Dist is Dist1 + Dist2.



getCaminhoPapel(Origem,Destino) :-
	findall((P,Dist),caminhoPapel(Origem,Destino,Dist,P),L),
	print(L).

caminhoPapel(Origem,Destino,Dist,[Origem|Percurso]) :-
	caminhoAuxPapel(Origem,Destino,Percurso,Dist,[]).

caminhoAuxPapel(Destino,Destino,[],0,_).
caminhoAuxPapel(Origem,Destino,[Proximo|Percurso],Dist,Visitados) :-
	Origem \= Destino,
	arcos_papel(Origem,Proximo,Dist1),
	\+member(Proximo,Visitados),
	caminhoAuxPapel(Proximo,Destino,Percurso,Dist2,[Origem|Visitados]),
	Dist is Dist1 + Dist2.



getCaminhoVidro(Origem,Destino) :-
	findall((P,Dist),caminhoVidro(Origem,Destino,Dist,P),L),
	print(L).

caminhoVidro(Origem,Destino,Dist,[Origem|Percurso]) :-
	caminhoAuxVidro(Origem,Destino,Percurso,Dist,[]).

caminhoAuxVidro(Destino,Destino,[],0,_).
caminhoAuxVidro(Origem,Destino,[Proximo|Percurso],Dist,Visitados) :-
	Origem \= Destino,
	arcos_vidro(Origem,Proximo,Dist1),
	\+member(Proximo,Visitados),
	caminhoAuxVidro(Proximo,Destino,Percurso,Dist2,[Origem|Visitados]),
	Dist is Dist1 + Dist2.


getCaminhoEmbalagem(Origem,Destino) :-
	findall((P,Dist),caminhoEmbalagem(Origem,Destino,Dist,P),L),
	print(L).

caminhoEmbalagem(Origem,Destino,Dist,[Origem|Percurso]) :-
	caminhoAuxEmbalagem(Origem,Destino,Percurso,Dist,[]).

caminhoAuxEmbalagem(Destino,Destino,[],0,_).
caminhoAuxEmbalagem(Origem,Destino,[Proximo|Percurso],Dist,Visitados) :-
	Origem \= Destino,
	arcos_embalagem(Origem,Proximo,Dist1),
	\+member(Proximo,Visitados),
	caminhoAuxEmbalagem(Proximo,Destino,Percurso,Dist2,[Origem|Visitados]),
	Dist is Dist1 + Dist2.




getCaminhoOrganico(Origem,Destino) :-
	findall((P,Dist),caminhoOrganico(Origem,Destino,Dist,P),L),
	print(L).

caminhoOrganico(Origem,Destino,Dist,[Origem|Percurso]) :-
	caminhoAuxOrganico(Origem,Destino,Percurso,Dist,[]).

caminhoAuxOrganico(Destino,Destino,[],0,_).
caminhoAuxOrganico(Origem,Destino,[Proximo|Percurso],Dist,Visitados) :-
	Origem \= Destino,
	arcos_organico(Origem,Proximo,Dist1),
	\+member(Proximo,Visitados),
	caminhoAuxOrganico(Proximo,Destino,Percurso,Dist2,[Origem|Visitados]),
	Dist is Dist1 + Dist2.

% -------------------------------- Depth first -----------------------------

resolve_pp(Nodo, [Nodo|Caminho]) :-
    profundidadeprimeiro1(Nodo, [Nodo], Caminho).

profundidadeprimeiro1(Nodo,_,[]) :- deposicao(Nodo).

profundidadeprimeiro1(Nodo,Historico,[ProxNodo|Caminho]) :-
    adjacente(Nodo,ProxNodo),
    \+member(ProxNodo,Historico),
    profundidadeprimeiro1(ProxNodo,[ProxNodo|Historico],Caminho).


% -------------------------------- Depth first com distinção de lixo ------------------------

resolve_ppLixo(Nodo,Lixo,[Nodo|Caminho]) :-
    profundidadeprimeiro1Lixo(Nodo, [Nodo], Caminho,Lixo).

profundidadeprimeiro1Lixo(Nodo,_,[],Lixo) :- deposicao(Nodo).
profundidadeprimeiro1Lixo(Nodo,Historico,[ProxNodo|Caminho],Lixo) :-
	(Lixo == "Lixo", adjacente_lixo(Nodo,ProxNodo);
	Lixo == "Papel", adjacente_papel(Nodo,ProxNodo);
	Lixo == "Vidro", adjacente_vidro(Nodo,ProxNodo);
	Lixo == "Embalagens", adjacente_embalagem(Nodo,ProxNodo);
	Lixo == "Organico", adjacente_organico(Nodo,ProxNodo)),
    \+member(ProxNodo,Historico),
    profundidadeprimeiro1Lixo(ProxNodo,[ProxNodo|Historico],Caminho,Lixo).


% ------------------------------ Depth first com custo ------------------------------------

resolve_ppC(NodoInicial, NodoDestino, [NodoInicial|Caminho], Custo) :-
    profundidadeprimeiro2(NodoInicial,NodoDestino,[NodoInicial], Caminho, Custo).

profundidadeprimeiro2(Nodo,Nodo,_,[],0).
profundidadeprimeiro2(Nodo,NodoFinal,Historico,[ProxNodo|Caminho],Custo) :-
    adjacenteC(Nodo,ProxNodo,C1),
    \+member(ProxNodo,Historico),
    profundidadeprimeiro2(ProxNodo,NodoFinal,[ProxNodo|Historico],Caminho,C2),
    Custo is C1 + C2.


% ------------------------------ Depth first com o custo para cada tipo de lixo -------------------------------

resolve_ppCLixo(NodoInicial, NodoDestino, Lixo, [NodoInicial|Caminho], Custo) :-
    profundidadeprimeiro2Lixo(NodoInicial,NodoDestino,[NodoInicial], Caminho, Custo,Lixo).

profundidadeprimeiro2Lixo(Nodo,Nodo,_,[],0,Lixo).
profundidadeprimeiro2Lixo(Nodo,NodoFinal,Historico,[ProxNodo|Caminho],Custo,Lixo) :-
    (Lixo == "Lixo", adjacenteC_lixo(Nodo,ProxNodo,C1);
	Lixo == "Papel", adjacenteC_papel(Nodo,ProxNodo,C1);
	Lixo == "Vidro", adjacenteC_vidro(Nodo,ProxNodo,C1);
	Lixo == "Embalagens", adjacenteC_embalagem(Nodo,ProxNodo,C1);
	Lixo == "Organico", adjacenteC_organico(Nodo,ProxNodo,C1)),
    \+member(ProxNodo,Historico),
    profundidadeprimeiro2Lixo(ProxNodo,NodoFinal,[ProxNodo|Historico],Caminho,C2,Lixo),
    Custo is C1 + C2.

% -------------------------------- Circuito mais rápido indiferenciado ----------------------------------

maisRapido(NodoInicial,NodoDestino,Caminho,Custo) :- findall((SS,CC), resolve_ppC(NodoInicial,NodoDestino,SS,CC), L), menorTuploLista(L, (Caminho,Custo)).

menorTuplo( (Z,X), (_,Y), (Z,X) ) :-
    X =< Y.
menorTuplo( (_,X),(W,Y),(W,Y) ) :-
    X > Y.

menorTuploLista( [X],X ).
menorTuploLista( [X|Y],N ) :-
    menorTuploLista( Y,Z ),
        menorTuplo( X,Z,N ).


% -------------------------------- Circuito mais rápido por tipo de lixo  -----------------------------------

maisRapidoLixo(NodoInicial,NodoDestino,Lixo,Caminho,Custo) :- findall((SS,CC), resolve_ppCLixo(NodoInicial,NodoDestino,Lixo,SS,CC), L), menorTuploLista(L, (Caminho,Custo)).

% -------------------------------- Circuito com mais pontos de recolha ---------------------------------------

maisPontos(NodoInicial,Caminho,Pontos) :- findall((C,N), (resolve_pp(NodoInicial,C),comprimento(C,N1), N is N1-2), L), maiorTuploLista(L,(Caminho,Pontos)).

maiorTuplo( (Z,X), (_,Y), (Z,X) ) :-
    X > Y.
maiorTuplo( (_,X),(W,Y),(W,Y) ) :-
    X =< Y.

maiorTuploLista( [X],X ).
maiorTuploLista( [X|Y],N ) :-
    maiorTuploLista( Y,Z ),
        maiorTuplo( X,Z,N ).
        
% ------------------------------- >Circuito com mais pontos de recolha de um lixo específico --------------------------
maisPontosLixo(NodoInicial,Lixo,Caminho,Pontos) :- findall((C,N), (resolve_pp(NodoInicial,C),comprimentoLixo(C,Lixo,N)), L), maiorTuploLista(L,(Caminho,Pontos)).

comprimentoLixo([],Lixo,0).
comprimentoLixo( [A|L],Lixo,N) :-
		comprimentoLixo(L,Lixo,N1),
		(((A \= 0, A \= 1000),((Lixo == "Lixo", ponto_recolha_lixo(_,_,A,_,_,_,_));
		(Lixo == "Papel", ponto_recolha_papel(_,_,A,_,_,_,_));
		(Lixo == "Vidro", ponto_recolha_vidro(_,_,A,_,_,_,_));
		(Lixo == "Embalagens", ponto_recolha_embalagem(_,_,A,_,_,_,_));
		(Lixo == "Organico", ponto_recolha_organico(_,_,A,_,_,_,_))),N is N1+1);
		((A ==0);( A== 1000);(Lixo \= "Lixo", Lixo \= "Papel", Lixo \= "Vidro", Lixo \= "Embalagens", Lixo \= "Organico");
		(Lixo == "Lixo", nao(ponto_recolha_lixo(_,_,A,_,_,_,_)));
		(Lixo == "Papel", nao(ponto_recolha_papel(_,_,A,_,_,_,_)));
		(Lixo == "Vidro", nao(ponto_recolha_vidro(_,_,A,_,_,_,_)));
		(Lixo == "Embalagens", nao(ponto_recolha_embalagem(_,_,A,_,_,_,_)));
		(Lixo == "Organico", nao(ponto_recolha_organico(_,_,A,_,_,_,_)))),
		N is N1).


% ----------------------------------- Comparar circuitos com os parâmetros de produtividade --------------------------------------


%circuitoMaisProdutivo

% ---------------------------------- Comparar circuitos com o parâmetro de eficiência --------------------------------------------

circuitoMaisEficiente(NodoInicial,Caminho,Quantidade) :- findall((C,N), (resolve_pp(NodoInicial,C),quantidadeLixo(C,N)), L), maiorTuploLista(L,(Caminho,Quantidade)).

quantidadeLixo([],0).
quantidadeLixo([A|L],N) :-
	quantidadeLixo(L,N1),
	ponto_recolha(_,_,A,_,_,_,C),
	N is N1+C.

% --------------------------------- Comparar circuitos com o parâmetro de eficiência por tipo de lixo -------------------------------

circuitoMaisEficienteLixo(NodoInicial,Lixo,Caminho,Quantidade) :- findall((C,N), (resolve_pp(NodoInicial,C),quantidadeLixoLixo(C,Lixo,N)), L), maiorTuploLista(L,(Caminho,Quantidade)).

quantidadeLixoLixo([],Lixo,0).
quantidadeLixoLixo([A|L],Lixo,N) :-
	quantidadeLixoLixo(L,Lixo,N1),
	(((A \= 0, A \= 1000),((Lixo == "Lixo", ponto_recolha_lixo(_,_,A,_,_,_,C));
	(Lixo == "Papel", ponto_recolha_papel(_,_,A,_,_,_,C));
	(Lixo == "Vidro", ponto_recolha_vidro(_,_,A,_,_,_,C));
	(Lixo == "Embalagens", ponto_recolha_embalagem(_,_,A,_,_,_,C));
	(Lixo == "Organico", ponto_recolha_organico(_,_,A,_,_,_,C))),N is N1+C);
	((A ==0);( A== 1000);(Lixo \= "Lixo", Lixo \= "Papel", Lixo \= "Vidro", Lixo \= "Embalagens", Lixo \= "Organico");
	(Lixo == "Lixo", nao(ponto_recolha_lixo(_,_,A,_,_,_,_)));
	(Lixo == "Papel", nao(ponto_recolha_papel(_,_,A,_,_,_,_)));
	(Lixo == "Vidro", nao(ponto_recolha_vidro(_,_,A,_,_,_,_)));
	(Lixo == "Embalagens", nao(ponto_recolha_embalagem(_,_,A,_,_,_,_)));
	(Lixo == "Organico", nao(ponto_recolha_organico(_,_,A,_,_,_,_)))),
	N is N1).

% -------------------------------- Caminho com Breadth first sem distinção de lixo -----------------------------


resolveBFS(Initial,Solution) :- 
    garagem(Initial),
    solveBFS([[Initial]],Solucao),
    reverse(Solucao,Solution,[]).

solveBFS([[N|Path]|_],[N|Path]) :- deposicao(N).
solveBFS([Path|Paths],Solution) :-
    extend(Path,NewPaths),
    append(Paths,NewPaths,Paths1),
    solveBFS(Paths1,Solution).


extend([Node|Path],NewPaths) :-
    findall([NewNode,Node|Path],
    (adjacente(Node,NewNode),
    \+member(NewNode,[Node|Path])),
    NewPaths).

extend(Path,_).

reverse([],Z,Z).

reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).



% ---------------------------------- Caminho com Breadth first com distinção de lixo -------------------------------------

resolveBFSLixo(Initial,Lixo,Solution) :- 
    garagem(Initial),
    solveBFSLixo([[Initial]],Lixo,Solucao),
    reverse(Solucao,Solution,[]).

solveBFSLixo([[N|Path]|_],Lixo,[N|Path]) :- deposicao(N).
solveBFSLixo([Path|Paths],Lixo,Solution) :-
    extendLixo(Path,Lixo,NewPaths),
    append(Paths,NewPaths,Paths1),
    solveBFSLixo(Paths1,Lixo,Solution).


extendLixo([Node|Path],Lixo,NewPaths) :-
    findall([NewNode,Node|Path],
    ((Lixo == "Lixo", adjacente_lixo(Node,NewNode);
	Lixo == "Papel", adjacente_papel(Node,NewNode);
	Lixo == "Vidro", adjacente_vidro(Node,NewNode);
	Lixo == "Embalagens", adjacente_embalagem(Node,NewNode);
	Lixo == "Organico", adjacente_organico(Node,NewNode)),
	\+member(NewNode,[Node|Path])),
    NewPaths).

extendLixo(Path,Lixo,_).

% ------------------------------------ Caminho com Gulosa ----------------------------------------------------------- 

adjacente3([Nodo|Caminho]/Custo/_,[ProxNodo,Nodo|Caminho]/NovoCusto/Est):-
        adjacenteC(Nodo,ProxNodo,PassoCusto), 
        \+member(ProxNodo,Caminho),
        NovoCusto is Custo + PassoCusto,
        estima(ProxNodo,Est).


resolve_gulosa(Nodo,Caminho/Custo):-
        estima(Nodo,Estima),
        agulosa([[Nodo]/0/Estima],InvCaminho/Custo/_),
        inverso(InvCaminho,Caminho).

agulosa(Caminhos,Caminho):-
        obtem_melhor_g(Caminhos,Caminho),
        Caminho = [Nodo|_]/_/_,
        deposicao(Nodo).

agulosa(Caminhos, SolucaoCaminho):-
        obtem_melhor_g(Caminhos,MelhorCaminho),
        seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
        expande_gulosa(MelhorCaminho,ExpCaminhos),
        append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        agulosa(NovoCaminhos,SolucaoCaminho).

expande_gulosa(Caminho,ExpCaminhos):-
        findall(NovoCaminho,adjacente3(Caminho,NovoCaminho),ExpCaminhos).


obtem_melhor_g([Caminho],Caminho):- !.
obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho):-
        Est1 =< Est2 , !, 
        obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

obtem_melhor_g([_|Caminhos],MelhorCaminho):-
        obtem_melhor_g(Caminhos,MelhorCaminho).


seleciona(E,[E|Xs],Xs).
seleciona(E,[X|Xs],[X|Ys]):- seleciona(E,Xs,Ys).


inverso(Xs,Ys):-
    inverso(Xs,[],Ys).

inverso([],Xs,Xs).
inverso([X|Xs],Ys,Zs):-
    inverso(Xs,[X|Ys],Zs).

%>
% -------------------------------------- Caminho com Gulosa por lixo --------------------------------------

resolve_gulosaLixo(Nodo,Lixo,Caminho/Custo):-
        estima(Nodo,Estima),
        agulosaLixo(Lixo,[[Nodo]/0/Estima],InvCaminho/Custo/_),
        inverso(InvCaminho,Caminho).

agulosaLixo(Lixo,Caminhos,Caminho):-
        obtem_melhor_g(Caminhos,Caminho),
        Caminho = [Nodo|_]/_/_,
        deposicao(Nodo).

agulosaLixo(Lixo,Caminhos, SolucaoCaminho):-
        obtem_melhor_g(Caminhos,MelhorCaminho),
        seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
        expande_gulosaLixo(Lixo,MelhorCaminho,ExpCaminhos),
        append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        agulosaLixo(Lixo,NovoCaminhos,SolucaoCaminho).

expande_gulosaLixo(Lixo,Caminho,ExpCaminhos):-
        findall(NovoCaminho,adjacente3Lixo(Lixo,Caminho,NovoCaminho),ExpCaminhos).


obtem_melhor_g([Caminho],Caminho):- !.
obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho):-
        Est1 =< Est2 , !, 
        obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

obtem_melhor_g([_|Caminhos],MelhorCaminho):-
        obtem_melhor_g(Caminhos,MelhorCaminho).
%>

adjacente3Lixo(Lixo,[Nodo|Caminho]/Custo/_,[ProxNodo,Nodo|Caminho]/NovoCusto/Est):-
		(Lixo == "Lixo", adjacenteC_lixo(Nodo,ProxNodo,PassoCusto);
		Lixo == "Papel", adjacenteC_papel(Nodo,ProxNodo,PassoCusto);
		Lixo == "Vidro", adjacenteC_vidro(Nodo,ProxNodo,PassoCusto);
		Lixo == "Embalagens", adjacenteC_embalagem(Nodo,ProxNodo,PassoCusto);
		Lixo == "Organico", adjacenteC_organico(Nodo,ProxNodo,PassoCusto)), 
        \+member(ProxNodo,Caminho),
        NovoCusto is Custo + PassoCusto,
        estima(ProxNodo,Est).

% ------------------------------------ Caminho com A* ------------------------------------------

resolve_aestrela(Nodo, Caminho/Custo) :-
    estima(Nodo,Estima),
    aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_),
    inverso(InvCaminho,Caminho).

aestrela(Caminhos,Caminho) :-
    obtem_melhor(Caminhos,Caminho),
    Caminho = [Nodo|_]/_/_,
    deposicao(Nodo).

aestrela(Caminhos,SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
    expande_aestrela(MelhorCaminho,ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovosCaminhos),
    aestrela(NovosCaminhos,SolucaoCaminho).

expande_aestrela(Caminho,ExpCaminhos):-
    findall(NovoCaminho,adjacente3(Caminho,NovoCaminho), ExpCaminhos).

obtem_melhor([Caminho],Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho):-
    Est1 + Custo1 =< Est2 + Custo2, !,
    obtem_melhor([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

obtem_melhor([_|Caminhos],MelhorCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho).


% ---------------------------------------------------------> Caminho com A* por lixo ----------------------------

resolve_aestrelaLixo(Nodo,Lixo, Caminho/Custo) :-
    estima(Nodo,Estima),
    aestrelaLixo(Lixo,[[Nodo]/0/Estima], InvCaminho/Custo/_),
    inverso(InvCaminho,Caminho).

aestrelaLixo(Lixo,Caminhos,Caminho) :-
    obtem_melhor(Caminhos,Caminho),
    Caminho = [Nodo|_]/_/_,
    deposicao(Nodo).

aestrelaLixo(Lixo,Caminhos,SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
    expande_aestrelaLixo(Lixo,MelhorCaminho,ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovosCaminhos),
    aestrelaLixo(Lixo,NovosCaminhos,SolucaoCaminho).

expande_aestrelaLixo(Lixo,Caminho,ExpCaminhos):-
    findall(NovoCaminho,adjacente3Lixo(Lixo,Caminho,NovoCaminho), ExpCaminhos).

obtem_melhor([Caminho],Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho):-
    Est1 + Custo1 =< Est2 + Custo2, !,
    obtem_melhor([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

obtem_melhor([_|Caminhos],MelhorCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho).
