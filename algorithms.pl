%Definição das arestas do Grafo
%sGH(G(n),H(n),VerticeOrigem,VerticeDestino)
sGH(63,40,a,b).
sGH(110,67,a,c).
sGH(53,45,a,e).
sGH(45,40,e,b).
sGH(65,40,b,d).
sGH(43,67,b,c).
sGH(45,40,c,d).
sGH(70,0,d,f).
sGH(52,0,e,f).
sGH(62,0,b,f).

% sG(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - usa função de custo G
sG(G,V1,V2):-sGH(G,_,V1,V2).
% sH(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - usa função de avaliação H
sH(H,V1,V2):-sGH(_,H,V1,V2).
% s(G(n),H(n),F(n),VerticeOrigem,VerticeDestino) - Não usa nenhuma heurística
s(V1,V2):-sGH(_,_,V1,V2).

%Definir o nó (estado) objetivo
objetivo(f).

%HILL CLIMBING

hillClimbing([[H, No|Caminho]|_], [H, Solucao]):-	
	objetivo(No),                            
	reverse([No|Caminho], Solucao).

hillClimbing([Caminho|Caminhos], Solucao) :-
	estendeHillClimbing(Caminho, NovosCaminhos),
    ordena(NovosCaminhos, CaminhosOrd),
    append(CaminhosOrd, Caminhos, Caminhos2),
    hillClimbing(Caminhos2, Solucao).
	
estendeHillClimbing([_,No|Caminho],PossiveisNos):-
	findall([HNovo,NovoNo,No|Caminho],
	(	sH(HN,No,NovoNo),
		not(member(NovoNo,[No|Caminho])),
		HNovo is HN),
	PossiveisNos).
	
%pergunta: hillClimbing([[75,a]],S).

%BEST FIRST

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

%pergunta: bestFirst([[75,a]],S).

%BRANCH AND BOUND

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