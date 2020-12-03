
%% mover para cima na linha central
move([A,B,C, -,E,F, G,H,I],
     [-,B,C, A,E,F, G,H,I]).
move([A,B,C, D,-,F, G,H,I],
     [A,-,C, D,B,F, G,H,I]).
move([A,B,C, D,E,-, G,H,I],
     [A,B,-, D,E,C, G,H,I]).

%% mover para cima na linha inferior
move([A,B,C, D,E,F, G,-,I],
     [A,B,C, D,-,F, G,E,I]).
move([A,B,C, D,E,F, G,H,-],
     [A,B,C, D,E,-, G,H,F]).
move([A,B,C, D,E,F, -,H,I],
     [A,B,C, -,E,F, D,H,I]).
% mover para esquerda na linha superior
move([A,-,C, D,E,F, G,H,I],
     [-,A,C, D,E,F, G,H,I]).
move([A,B,-, D,E,F, G,H,I],
     [A,-,B, D,E,F, G,H,I]).

%% mover para esquerda na linha central
move([A,B,C, D,-,F,G,H,I],
     [A,B,C, -,D,F,G,H,I]).
move([A,B,C, D,E,-,G,H,I],
     [A,B,C, D,-,E,G,H,I]).

%% mover para esquerda na linha inferior
move([A,B,C, D,E,F, G,-,I],
     [A,B,C, D,E,F, -,G,I]).
move([A,B,C, D,E,F, G,H,-],
     [A,B,C, D,E,F, G,-,H]).

%% mover linha superior para direita
move([-,B,C, D,E,F, G,H,I],
     [B,-,C, D,E,F, G,H,I]).
move([A,-,C, D,E,F, G,H,I],
     [A,C,-, D,E,F, G,H,I]).

%% mover linha central para direita
move([A,B,C, -,E,F, G,H,I],
     [A,B,C, E,-,F, G,H,I]).
move([A,B,C, D,-,F, G,H,I],
     [A,B,C, D,F,-, G,H,I]).

%% mover para direita na linha inferior
move([A,B,C, D,E,F,-,H,I],
     [A,B,C, D,E,F,H,-,I]).
move([A,B,C, D,E,F,G,-,I],
     [A,B,C, D,E,F,G,I,-]).

%% mover para baixo na linha superior
move([-,B,C, D,E,F, G,H,I],
     [D,B,C, -,E,F, G,H,I]).
move([A,-,C, D,E,F, G,H,I],
     [A,E,C, D,-,F, G,H,I]).
move([A,B,-, D,E,F, G,H,I],
     [A,B,F, D,E,-, G,H,I]).

%% mover para baixo na linha central
move([A,B,C, -,E,F, G,H,I],
     [A,B,C, G,E,F, -,H,I]).
move([A,B,C, D,-,F, G,H,I],
     [A,B,C, D,H,F, G,-,I]).
move([A,B,C, D,E,-, G,H,I],
     [A,B,C, D,E,I, G,H,-]).




avaliaPuzzle([A,B,C,D,E,F,G,H,I,J], pontuacao):-
    avaliaPeca(1,[A,B,C,D,E,F,G,H,I,J], pt1),
    avaliaPeca(2,[A,B,C,D,E,F,G,H,I,J], pt2),
    avaliaPeca(3,[A,B,C,D,E,F,G,H,I,J], pt3),
    avaliaPeca(4,[A,B,C,D,E,F,G,H,I,J], pt4),
    avaliaPeca(5,[A,B,C,D,E,F,G,H,I,J], pt5),
    avaliaPeca(6,[A,B,C,D,E,F,G,H,I,J], pt6),
    avaliaPeca(7,[A,B,C,D,E,F,G,H,I,J], pt7),
    avaliaPeca(8,[A,B,C,D,E,F,G,H,I,J], pt8),
    pontuacao is pt1+pt2+pt3+pt4+pt5+pt6+pt7+pt8
    
