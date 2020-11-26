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
      [4,5,6],
      [7,8,0]]).

dfs(S, Path, Path) :- goal(S).

dfs(S, Checked, Path) :-
    % try a move
    move(S, S2),
    % ensure the resulting state is new
    \+member(S2, Checked),
    % and that this state leads to the goal
    dfs(S2, [S2|Checked], Path).