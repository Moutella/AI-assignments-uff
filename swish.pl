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

/*objetivo([[0,1,2],
      [3,4,5],
      [6,7,8]]).*/

/*objetivo([[1,2, 3],
      [4,5, 6],
      [7,8, 0]]).*/

move(P1,P2, 'up'):- up(P1,P2).
move(P1,P2, 'left'):- left(P1,P2).
move(P1,P2, 'right'):- right(P1,P2).
move(P1,P2, 'down'):- down(P1,P2).

% move([[8,2,3], [0,4,5], [6,7,1]],EstadoFuturo,'right'),
% move(EstadoFuturo,EstadoFuturo2,'up')


indexOf([], _, -4):- !. % se não estivar na lista, retornará -1(stonks) RIP GENERICIDADE
indexOf([Element|_], Element, 0):-!. % We found the element
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), % Check in the tail of the list
  Index is Index1+1.  % and increment the resulting index


falseEhZero(false,0):- !.
falseEhZero(Value,Value).

nivel(X,-1,-1,1,X):- !.
nivel(-1,X,-1,2,X):- !.
nivel(-1,-1,X,3,X).


geraPontuacao(IAtual,IDest,JAtual,JDest,E):-
    E is abs(IAtual-IDest) + abs(JAtual-JDest).

avaliaPeca(_, 0, 0):- !.
avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], X, Pts):-
 	indexOf([A,B,C],X,IndexAtual1),
    indexOf([D,E,F],X,IndexAtual2),
    indexOf([G,H,I],X,IndexAtual3),
    nivel(IndexAtual1,IndexAtual2,IndexAtual3,JAtual,IAtual),
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
    PtsPuzzle is PtsA+PtsB+PtsC+PtsD+PtsE+PtsF+PtsG+PtsH+PtsI.
1
%- avaliaPuzzle([[8,2,3], [0,4,5], [6,7,1]],Pts).

estendeBestFirst([_, Puzzle], Puzzles, Novos):-
    findall([HNovo, PuzzleNovo], 
    (     
          move(Puzzle, PuzzleNovo,_), 
          avaliaPuzzle(PuzzleNovo, HNovo),
          not(member([HNovo, PuzzleNovo],Puzzles)))
    , Novos).
    
% estendeBestFirst([0, [[8,2,3], [0,4,5], [6,7,1]]],Novos).

%Gera a solução se o nó sendo visitado é um nó objetivo
%O nó gerado no passo anterior é um nó objetivo
bestFirst([[H,Puzzle]|_],[H,Puzzle]):-	
	objetivo(Puzzle), !.
	
%O nó corrente não é um nó objetivo
bestFirst([Puzzle|Puzzles], Solucao) :-
	estendeBestFirst(Puzzle, Puzzles, NovosPuzzles), %Gera novos Puzzles
    ordena(NovosPuzzles,Puzzles2),
    
	append(Puzzles2,Puzzles,PuzzlesOrd),
    print('Puzzles: '),
    print(Puzzles),
    nl(),
     print('Puzzles2: '),
    print(Puzzles2),
    nl(),
    print('PuzzlesOrd: '),
    print(PuzzlesOrd),
    nl(),
    %ordena(NovosPuzzles,Puzzles2),
    /*print('NovosEstados'),
    print(Puzzles2),
    print('-------------------------------------------'),*/
	bestFirst(PuzzlesOrd, Solucao). 	
	%Coloca o nó corrente no Puzzle e continua a recursão

% bestFirst([[0, [[8,2,3], [0,4,5], [6,7,1]]]],Novos).
% bestFirst([[0, [[0,2,3], [1,4,5], [6,7,8]]]],Novos).

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



dfs(S, Path, Path) :- goal(S).

dfs(S, Checked, Path) :-
    % try a move
    move(S, S2),
    % ensure the resulting state is new
    \+member(S2, Checked),
    % and that this state leads to the goal
    dfs(S2, [S2|Checked], Path).