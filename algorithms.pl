%Definição das arestas do Grafo
%sGH(G(n),H(n),VerticeOrigem,VerticeDestino)
sGH(63,40,a,b).
sGH(110,67,a,c).
sGH(53,45,a,e).
sGH(45,40,e,b).
sGH(65,40,b,d).
sGH(67,43,b,c).
sGH(45,40,c,d).
sGH(70,0,d,f).
sGH(52,0,e,f).
sGH(62,0,b,f).

% sG(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - usa função de custo G
sG(G,V1,V2):-sGH(G,_,V1,V2).
% sH(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - usa função de avaliação H
%sH(H,V1,V2):-sGH(H,_,V1,V2).
sH(H,V1,V2):-sGH(_,H,V1,V2).
% s(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - Não usa nenhuma heurística
s(V1,V2):-sGH(_,_,V1,V2).

%Definir o nó (estado) objetivo
objetivo(f).

membro(X,[X|_]):-!.
membro(X,[_|L]):-
    membro(X,L).

%hill climbing

%Gera a solução se o nó sendo visitado é um nó objetivo
%O nó colocado no caminho no passo anterior é um nó objetivo
hillClimbing([H, Caminho], NoCorrente, [H, Solucao]):-	
	objetivo(NoCorrente),                            
	reverse(Caminho,Solucao).
%O nó corrente não é um nó objetivo
hillClimbing([H, Caminho], NoCorrente, Solucao) :-
	geraNovo(NoCorrente, NoNovo, HNovo),				%Gera um novo estado
	not(membro(NoNovo, Caminho)),	 %Evita ciclos na busca
    append([NoNovo], Caminho, NovoCaminho),
	hillClimbing([HNovo, NovoCaminho], NoNovo, Solucao). 
	%Coloca o nó corrente no caminho e continua a recursão

%pergunta: hillClimbing([40, [a]], a, S).

geraNovo(NoCorrente, NoNovo, HNovo):-
    geraCaminhos(NoCorrente, PossiveisNos),
    min([HNovo, NoNovo], PossiveisNos).

geraCaminhos(NoCorrente, NovosCaminhos):-
    findall([HNovo,NovoNo],
(	sH(HN,NoCorrente,NovoNo),
	HNovo is HN), NovosCaminhos).

min([[X,N1]],[[X,N1]]).
min([X,N1],[[Y,_]|R]):- min([X, N1],R), X < Y, !.
min([Y,N2],[[Y,N2]|_]).

%best first

%Gera a solução se o nó sendo visitado é um nó objetivo
%O nó gerado no passo anterior é um nó objetivo
bestFirst([[H,No|Caminho]|_],[H,Solucao]):-	
	objetivo(No),
	reverse([No|Caminho],Solucao).
%O nó corrente não é um nó objetivo
bestFirst([Caminho|Caminhos], Solucao) :-
	estendeBestFirst(Caminho, NovosCaminhos), %Gera novos caminhos
	append(Caminhos,NovosCaminhos,Caminhos1),	
	ordena(Caminhos1,Caminhos2),
	bestFirst(Caminhos2, Solucao). 	
	%Coloca o nó corrente no caminho e continua a recursão

%Gera todos os Caminhos possiveis a partir de Caminho.
estendeBestFirst([_,No|Caminho],NovosCaminhos):-
findall([HNovo,NovoNo,No|Caminho],
(	sH(HN,No,NovoNo),
	not(member(NovoNo,[No|Caminho])),
	HNovo is HN),
NovosCaminhos).

%pergunta: bestFirst([[40,a]],S).

%Branch and bound
%Gera a solução se o nó sendo visitado é um nó objetivo
%O nó gerado no passo anterior é um nó objetivo
branchBound([[H,No|Caminho]|_],[H,Solucao]):-	
	objetivo(No),
	reverse([No|Caminho],Solucao).
%O nó corrente não é um nó objetivo
branchBound([Caminho|Caminhos], Solucao) :-
	estendeBranchBound(Caminho, NovosCaminhos), %Gera novos caminhos
	append(Caminhos,NovosCaminhos,Caminhos1),	
	ordena(Caminhos1,Caminhos2),
	branchBound(Caminhos2, Solucao). 	
	%Coloca o nó corrente no caminho e continua a recursão

%Gera todos os Caminhos possiveis a partir de Caminho.
estendeBranchBound([GC,No|Caminho],NovosCaminhos):-
findall([GNovo,NovoNo,No|Caminho],
(	sG(GN,No,NovoNo),
	not(member(NovoNo,[No|Caminho])),
	GNovo is GN + GC),
NovosCaminhos).

%pergunta: branchBound([[0,a]],S).

%Ordenas os Caminhos por F
ordena(Caminhos,CaminhosOrd):-
	quicksort(Caminhos,CaminhosOrd).

quicksort([],[]).
quicksort([X|Cauda],ListaOrd):-
	particionar(X,Cauda,Menor,Maior),
	quicksort(Menor,MenorOrd),
	quicksort(Maior,MaiorOrd),
	append(MenorOrd,[X|MaiorOrd],ListaOrd).

particionar(_,[],[],[]).
particionar(X,[Y|Cauda],[Y|Menor],Maior):-
	maior(X,Y),!,
	particionar(X,Cauda,Menor,Maior).
particionar(X,[Y|Cauda],Menor,[Y|Maior]):-
	particionar(X,Cauda,Menor,Maior).

maior([F1|_],[F2|_]) :- F1 > F2.