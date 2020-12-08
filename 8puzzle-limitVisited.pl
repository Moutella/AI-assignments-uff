%% mover para cima na linha central
up([[A,B,C], [0,E,F], [G,H,I]],
   [[0,B,C], [A,E,F], [G,H,I]]).
up([[A,B,C], [D,0,F], [G,H,I]],
   [[A,0,C], [D,B,F], [G,H,I]]).
up([[A,B,C], [D,E,0], [G,H,I]],
   [[A,B,0], [D,E,C], [G,H,I]]).

%% mover para cima na linha inferior
up([[A,B,C], [D,E,F], [G,0,I]],
   [[A,B,C], [D,0,F], [G,E,I]]).
up([[A,B,C], [D,E,F], [G,H,0]],
   [[A,B,C], [D,E,0], [G,H,F]]).
up([[A,B,C], [D,E,F], [0,H,I]],
   [[A,B,C], [0,E,F], [D,H,I]]).
% mover para esquerda na linha superior
left([[A,0,C], [D,E,F], [G,H,I]],
     [[0,A,C], [D,E,F], [G,H,I]]).
left([[A,B,0], [D,E,F], [G,H,I]],
     [[A,0,B], [D,E,F], [G,H,I]]).

%% mover para esquerda na linha central
left([[A,B,C], [D,0,F],[G,H,I]],
     [[A,B,C], [0,D,F],[G,H,I]]).
left([[A,B,C], [D,E,0],[G,H,I]],
     [[A,B,C], [D,0,E],[G,H,I]]).

%% mover para esquerda na linha inferior
left([[A,B,C], [D,E,F], [G,0,I]], 
     [[A,B,C], [D,E,F], [0,G,I]]).
left([[A,B,C], [D,E,F], [G,H,0]],
     [[A,B,C], [D,E,F], [G,0,H]]).

%% mover linha superior para direita
right([[0,B,C], [D,E,F], [G,H,I]],
      [[B,0,C], [D,E,F], [G,H,I]]).
right([[A,0,C], [D,E,F], [G,H,I]],
	 [[A,C,0], [D,E,F], [G,H,I]]).

%% mover linha central para direita
right([[A,B,C], [0,E,F], [G,H,I]],
      [[A,B,C], [E,0,F], [G,H,I]]).
right([[A,B,C], [D,0,F], [G,H,I]],
      [[A,B,C], [D,F,0], [G,H,I]]).

%% mover para direita na linha inferior
right([[A,B,C], [D,E,F],[0,H,I]],
      [[A,B,C], [D,E,F],[H,0,I]]).
right([[A,B,C], [D,E,F],[G,0,I]],
      [[A,B,C], [D,E,F],[G,I,0]]).

%% mover para baixo na linha superior
down([[0,B,C], [D,E,F], [G,H,I]],
     [[D,B,C], [0,E,F], [G,H,I]]).
down([[A,0,C], [D,E,F], [G,H,I]],
     [[A,E,C], [D,0,F], [G,H,I]]).
down([[A,B,0], [D,E,F], [G,H,I]],
     [[A,B,F], [D,E,0], [G,H,I]]).

%% mover para baixo na linha central
down([[A,B,C], [0,E,F], [G,H,I]],
     [[A,B,C], [G,E,F], [0,H,I]]).
down([[A,B,C], [D,0,F], [G,H,I]],
     [[A,B,C], [D,H,F], [G,0,I]]).
down([[A,B,C], [D,E,0], [G,H,I]],
     [[A,B,C], [D,E,I], [G,H,0]]).


objetivo([[1,2,3],
          [4,0,5],
          [6,7,8]]).


move(P1,P2, 'up'):- up(P1,P2).
move(P1,P2, 'left'):- left(P1,P2).
move(P1,P2, 'right'):- right(P1,P2).
move(P1,P2, 'down'):- down(P1,P2).

% move([[8,2,3], [0,4,5], [6,7,1]],EstadoFuturo,'right'),
% move(EstadoFuturo,EstadoFuturo2,'up')


indexOf([], _, -4):- !. % se não estivar na lista, retornará -1. não genérico, apenas para listas que sabemos que tem 3 elementos sempre
indexOf([Element|_], Element, 0):-!. % achou o elemento
indexOf([_|Tail], Element, Index):-
     indexOf(Tail, Element, Index1), % verificar no final da lista
     Index is Index1+1.  % e incrementa o índice resultante

% encontra a posição j de um elemento
nivel(X,-1,-1,1,X):- !.
nivel(-1,X,-1,2,X):- !.
nivel(-1,-1,X,3,X).


geraPontuacao(IAtual,IDest,JAtual,JDest,E):-
     E is abs(IAtual-IDest) + abs(JAtual-JDest).


% utiliza a distancia de manhatam para gerar uma pontuação
avaliaPeca(_, 0, 0):- !.
avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], X, Pts):-
     indexOf([A,B,C],X,IndexAtual1),
     indexOf([D,E,F],X,IndexAtual2),
     indexOf([G,H,I],X,IndexAtual3),
     nivel(IndexAtual1,IndexAtual2,IndexAtual3,JAtual,IAtual), % descobre em qual nível o elemento X se encontra
     objetivo([L1,L2,L3]),
     indexOf(L1,X,IndexDest1),
     indexOf(L2,X,IndexDest2),
     indexOf(L3,X,IndexDest3),
     nivel(IndexDest1,IndexDest2,IndexDest3,JDest,IDest),
     geraPontuacao(IAtual,IDest,JAtual,JDest, Pts).
    

avaliaPuzzle([[A,B,C],[D,E,F],[G,H,I]], PtsPuzzle):-
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], A, PtsA),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], B, PtsB),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], C, PtsC),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], D, PtsD),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], E, PtsE),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], F, PtsF),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], G, PtsG),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], H, PtsH),
    avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], I, PtsI),
    PtsPuzzle is PtsA + PtsB + PtsC + PtsD + PtsE + PtsF + PtsG + PtsH + PtsI.

%- avaliaPuzzle([[8,2,3], [0,4,5], [6,7,1]],Pts).

estende([_, Puzzle], Puzzles, Visitados , Novos):-
    findall([HNovo, PuzzleNovo], 
    (     
          move(Puzzle, PuzzleNovo,_), 
          avaliaPuzzle(PuzzleNovo, HNovo),
          not(member([_, PuzzleNovo],Puzzles)),
          not(member([_, PuzzleNovo],Visitados))
     )
     , Novos).
    
% estende([0, [[8,2,3], [0,4,5], [6,7,1]]],Novos).


% BEST FIRST

bestFirst([[H,Puzzle]|_],_,[H,Puzzle]):-
     objetivo(Puzzle), !.
	

bestFirst([Puzzle|Puzzles], Visitados, Solucao) :-
	estende(Puzzle, Puzzles, Visitados, NovosPuzzles), 
	append(Puzzles,NovosPuzzles,Puzzles1),
     append([Puzzle], Visitados, Visitados2),
	ordena(Puzzles1,Puzzles2),
	bestFirst(Puzzles2, Visitados2, Solucao). 	


%? - bestFirst([[0, [[1,8,2], [0,4,3], [7,6,5]]]], [], Solucao).
%? - bestFirst([[0, [[1,8,0], [2,4,3], [7,6,5]]]], [], Solucao).


% A ESTRELA

estendeAEstrela(G, [_, Puzzle], Puzzles, Visitados , Novos):-
    findall([FNovo, PuzzleNovo], 
     (     
          move(Puzzle, PuzzleNovo,_), 
          avaliaPuzzle(PuzzleNovo, HNovo),
          not(member([_, PuzzleNovo],Puzzles)),
          not(member([_, PuzzleNovo],Visitados)),
          FNovo is HNovo + G
     )
     , Novos).
    

aEstrela(_, [[F,Puzzle]|_],_,[F,Puzzle]):-
	objetivo(Puzzle), !.
	

aEstrela(G, [Puzzle|Puzzles], Visitados, Solucao) :-
     GNovo is G + 1,
	estendeAEstrela(GNovo, Puzzle, Puzzles, Visitados, NovosPuzzles),
	append(Puzzles,NovosPuzzles,Puzzles1),
     append([Puzzle], Visitados, Visitados2),
	ordena(Puzzles1,Puzzles2),
	aEstrela(GNovo, Puzzles2, Visitados2, Solucao). 	


% Ineficiente
%- Teoria 1:
%- Acaba sendo pior que o best first, devido a baixa rquantidade de valores possiveis para h(n)
%- Expandimos muito os passos iniciais, o que não ajuda muito
%- aEstrela(0, [[0, [[1,2,3], [4,7,5], [6,8,0]]]], [[0, [[1,2,3], [4,7,5], [6,8,0]]]], Solucao).


% HILL CLIMBING

hillClimbing([[H,Puzzle]|_], _, [H,Puzzle]):-
     objetivo(Puzzle), !.
	

hillClimbing([Puzzle|Puzzles], Visitados, Solucao) :-
	estende(Puzzle, Puzzles, Visitados, NovosPuzzles), 
     ordena(NovosPuzzles, PuzzlesOrd),
	append(PuzzlesOrd,Puzzles,Puzzles1),
     append([Puzzle], Visitados, Visitados2),
	hillClimbing(Puzzles1, Visitados2, Solucao).

%? - hillClimbing([[0, [[1,8,2], [0,4,3], [7,6,5]]]], [], Solucao).
%? - hillClimbing([[0, [[1,8,0], [2,4,3], [7,6,5]]]], [], Solucao).


% BRANCH AND BOUND

estendeBranchBound([G, Puzzle], Puzzles, Visitados , Novos):-
    findall([GNovo, PuzzleNovo], 
    (     
          move(Puzzle, PuzzleNovo,_), 
          not(member([_, PuzzleNovo],Puzzles)),
          not(member([_, PuzzleNovo],Visitados)),
          GNovo is G + 1
     )
     , Novos).

branchBound([[G,Puzzle]|_], _, [G,Puzzle]):-	
	objetivo(Puzzle), !.
	

branchBound([Puzzle|Puzzles], Visitados, Solucao) :-
	estendeBranchBound(Puzzle, Puzzles, Visitados, NovosPuzzles), 
	append(Puzzles,NovosPuzzles,Puzzles1),	
     append([Puzzle], Visitados, Visitados2),
	ordena(Puzzles1, Puzzles2),
	branchBound(Puzzles2, Visitados2, Solucao). 	

%? - branchBound([[0, [[1,8,2], [0,4,3], [7,6,5]]]], [], Solucao).
%? - branchBound([[0, [[1,8,0], [2,4,3], [7,6,5]]]], [], Solucao).


% Ordenação
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