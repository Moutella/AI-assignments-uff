%% mover para cima na linha central
move([[A,B,C], [0,E,F], [G,H,I]],
	[[0,B,C], [A,E,F], [G,H,I]]).
move([[A,B,C], [D,0,F], [G,H,I]],
	[[A,0,C], [D,B,F], [G,H,I]]).
move([[A,B,C], [D,E,0], [G,H,I]],
     [[A,B,0], [D,E,C], [G,H,I]]).

%% mover para cima na linha inferior
move([[A,B,C], [D,E,F], [G,0,I]],
     [[A,B,C], [D,0,F], [G,E,I]]).
move([[A,B,C], [D,E,F], [G,H,0]],
     [[A,B,C], [D,E,0], [G,H,F]]).
move([[A,B,C], [D,E,F], [0,H,I]],
     [[A,B,C], [0,E,F], [D,H,I]]).
% mover para esquerda na linha superior
move([[A,0,C], [D,E,F], [G,H,I]],
     [[0,A,C], [D,E,F], [G,H,I]]).
move([[A,B,0], [D,E,F], [G,H,I]],
     [[A,0,B], [D,E,F], [G,H,I]]).

%% mover para esquerda na linha central
move([[A,B,C], [D,0,F],[G,H,I]],
     [[A,B,C], [0,D,F],[G,H,I]]).
move([[A,B,C], [D,E,0],[G,H,I]],
     [[A,B,C], [D,0,E],[G,H,I]]).

%% mover para esquerda na linha inferior
move([[A,B,C], [D,E,F], [G,0,I]], 
     [[A,B,C], [D,E,F], [0,G,I]]).
move([[A,B,C], [D,E,F], [G,H,0]],
     [[A,B,C], [D,E,F], [G,0,H]]).

%% mover linha superior para direita
move([[0,B,C], [D,E,F], [G,H,I]],
     [[B,0,C], [D,E,F], [G,H,I]]).
move([[A,0,C], [D,E,F], [G,H,I]],
	[[A,C,0], [D,E,F], [G,H,I]]).

%% mover linha central para direita
move([[A,B,C], [0,E,F], [G,H,I]],
     [[A,B,C], [E,0,F], [G,H,I]]).
move([[A,B,C], [D,0,F], [G,H,I]],
     [[A,B,C], [D,F,0], [G,H,I]]).

%% mover para direita na linha inferior
move([[A,B,C], [D,E,F],[0,H,I]],
     [[A,B,C], [D,E,F],[H,0,I]]).
move([[A,B,C], [D,E,F],[G,0,I]],
     [[A,B,C], [D,E,F],[G,I,0]]).

%% mover para baixo na linha superior
move([[0,B,C], [D,E,F], [G,H,I]],
     [[D,B,C], [0,E,F], [G,H,I]]).
move([[A,0,C], [D,E,F], [G,H,I]],
     [[A,E,C], [D,0,F], [G,H,I]]).
move([[A,B,0], [D,E,F], [G,H,I]],
     [[A,B,F], [D,E,0], [G,H,I]]).

%% mover para baixo na linha central
move([[A,B,C], [0,E,F], [G,H,I]],
     [[A,B,C], [G,E,F], [0,H,I]]).
move([[A,B,C], [D,0,F], [G,H,I]],
     [[A,B,C], [D,H,F], [G,0,I]]).
move([[A,B,C], [D,E,0], [G,H,I]],
     [[A,B,C], [D,E,I], [G,H,0]]).


goal([[1,2,3],
      [4,0,5],
      [6,7,8]]).



indexOf([], _, -4):- !. % se não estivar na lista, retornará -1(stonks) RIP GENERICIDADE
indexOf([Element|_], Element, 0):-!. % We found the element
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), % Check in the tail of the list
  Index is Index1+1.  % and increment the resulting index


falseEhZero(false,0):- !.
falseEhZero(Value,Value).

nivel(X,-1,-1,1,X).
nivel(-1,X,-1,2,X).
nivel(-1,-1,X,3,X).


geraPontuacao(IAtual,IDest,JAtual,JDest,E):-
    E is abs(IAtual-IDest) + abs(JAtual-JDest).
avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], X, Pts):-
 	indexOf([A,B,C],X,IndexAtual1),
    indexOf([D,E,F],X,IndexAtual2),
    indexOf([G,H,I],X,IndexAtual3),
    nivel(IndexAtual1,IndexAtual2,IndexAtual3,JAtual,IAtual),
    goal([L1,L2,L3]),
    indexOf(L1,X,IndexDest1),
    indexOf(L2,X,IndexDest2),
    indexOf(L3,X,IndexDest3),
    nivel(IndexDest1,IndexDest2,IndexDest3,JDest,IDest),
    geraPontuacao(IAtual,IDest,JAtual,JDest, Pts).
    
    
%avaliaPuzzle([[A,B,C],[D,E,F],[G,H,I]], pontuacao):-
 %   avaliaPeca([[A,B,C],[D,E,F],[G,H,I]], 1, pt1),
  % 	pontuacao is pt1+0.
    
  
    

dfs(S, Path, Path) :- goal(S).

dfs(S, Checked, Path) :-
    % try a move
    move(S, S2),
    % ensure the resulting state is new
    \+member(S2, Checked),
    % and that this state leads to the goal
    dfs(S2, [S2|Checked], Path).