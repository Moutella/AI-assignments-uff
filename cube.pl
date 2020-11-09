%Gira a cima, X->Y horário, X<-Y anti-horário
%são equivalentes a girar o baixo anti-horário/horário
cimaHorario([[Cima1,Cima2,Cima3,Cima4],
            [Frente1,Frente2,Frente3,Frente4],
            [Dir1,Dir2,Dir3,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Esq2,Esq3,Esq4],
            [Baixo1,Baixo2,Baixo3,Baixo4]],         
            [[Cima4,Cima1,Cima2,Cima3],
            [Esq1,Esq2,Frente3,Frente4],
            [Frente1,Frente2,Dir3,Dir4],
            [Dir1,Dir2,Tras3,Tras4],
            [Tras1,Tras2,Esq3,Esq4],
            [Baixo1,Baixo2,Baixo3,Baixo4]]
            ).


%Gira a direita, X->Y horário, X<-Y anti-horário
%são equivalentes a girar a esquerda anti-horário/horário
direitaHorario([[Cima1,Cima2,Cima3,Cima4],
            [Frente1,Frente2,Frente3,Frente4],
            [Dir1,Dir2,Dir3,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Esq2,Esq3,Esq4],
            [Baixo1,Baixo2,Baixo3,Baixo4]], 
            [[Cima1,Frente2,Cima3,Frente4],
            [Frente1,Baixo2,Frente3,Baixo4],
            [Dir4, Dir1,Dir2,Dir3],
            [Cima4,Tras2,Cima2,Tras4],
            [Esq1,Esq2,Esq3,Esq4],
            [Baixo1,Tras3,Baixo3,Tras1]]
).

%Gira a frente, X->Y horário, X<-Y anti-horário
%são equivalentes a girar atrás anti-horário/horário
frenteHorario([[Cima1,Cima2,Cima3,Cima4],
            [Frente1,Frente2,Frente3,Frente4],
            [Dir1,Dir2,Dir3,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Esq2,Esq3,Esq4],
            [Baixo1,Baixo2,Baixo3,Baixo4]], 
            [[Cima1,Cima2,Esq2,Esq4],
            [Frente4,Frente1,Frente2,Frente3],
            [Cima3, Dir2,Cima4,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Baixo1,Esq3,Baixo2],
            [Dir3,Dir1,Baixo3,Baixo4]]
).