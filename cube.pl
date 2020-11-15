%Gira a cima, X->Y horário, X<-Y anti-horário
%são equivalentes a girar o baixo anti-horário/horário
cimaHorario([[Cima1,Cima2,Cima3,Cima4],
            [Frente1,Frente2,Frente3,Frente4],
            [Dir1,Dir2,Dir3,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Esq2,Esq3,Esq4],
            [Baixo1,Baixo2,Baixo3,Baixo4]],
            
            [[Cima4,Cima1,Cima3,Cima2],
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
            [Dir4, Dir1,Dir3,Dir2],
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
              
            [[Cima1,Cima2,Esq4,Esq2],
            [Frente4,Frente1,Frente3,Frente2],
            [Cima3, Dir2,Cima4,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Baixo1,Esq3,Baixo2],
            [Dir3,Dir1,Baixo3,Baixo4]]
).


%frenteHorario([[azul,azul,azul,azul],
%     [vermelho,vermelho,vermelho,vermelho],
%     [amarelo,amarelo,amarelo,amarelo],
%     [laranja,laranja,laranja,laranja],
%     [branco,branco,branco,branco],
%     [verde,verde,verde,verde]],
%	X
%), 
%frenteHorario(X,Y), 
%frenteHorario(Y,Z),
%direitaHorario(Z,Z2),
%direitaHorario(Z2,Z3),
%cimaHorario(Z3,Z4).
%Cubo gerado:
%[
%  [verde, azul, amarelo, branco],
%  [branco, azul, vermelho, laranja],
%  [vermelho, laranja, verde, verde],
%  [amarelo, amarelo, vermelho, laranja],
%  [vermelho, laranja, branco, azul],
%  [branco, azul, verde, amarelo]
% ]
    
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

avaliador(2, _, 0).
avaliador(_, Max, Max).


cabeca_calda(X, [X|Y], Y).
maximo(X,L):-
    cabeca_calda(LISTA_CABECA, L, LISTA_RESTO),
    maximo(X,LISTA_RESTO),
    X > LISTA_CABECA, !.
maximo(X,[X]).
maximo(X,[X|_]).

avaliadorLado(Vals, Valor):-
	count(Vals, 2, CoresComDois),
    maximo(MAX, Vals),
    avaliador(CoresComDois, MAX, Valor).
    
    


contaLado(Lado, Valor):-
    count(Lado, amarelo, ValorAmarelo),
    count(Lado, azul, ValorAzul),
    count(Lado, branco, ValorBranco),
    count(Lado, vermelho, ValorVermelho),
    count(Lado, laranja, ValorLaranja),
    count(Lado, verde, ValorVerde),
    avaliadorLado([
		ValorAmarelo, ValorAzul, ValorVermelho,
		ValorLaranja, ValorVerde, ValorBranco], Valor).



contaCubo([L1,L2,L3,L4,L5,L6], ValorCubo):-
    contaLado(L1, Val1),
    contaLado(L2, Val2),
    contaLado(L3, Val3),
    contaLado(L4, Val4),
    contaLado(L5, Val5),
    contaLado(L6, Val6),
    ValorCubo is Val1+Val2+Val3+Val4+Val5+Val6.