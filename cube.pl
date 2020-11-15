%Gira a cima, X->Y horário, X<-Y anti-horário
%são equivalentes a girar o baixo anti-horário/horário
cimaHorario([[Cima3,Cima1,Cima4,Cima2],
            [Esq1,Esq2,Frente3,Frente4],
            [Frente1,Frente2,Dir3,Dir4],
            [Dir1,Dir2,Tras3,Tras4],
            [Tras1,Tras2,Esq3,Esq4],
            [Baixo1,Baixo2,Baixo3,Baixo4]],
            
            [[Cima1,Cima2,Cima3,Cima4],
            [Frente1,Frente2,Frente3,Frente4],
            [Dir1,Dir2,Dir3,Dir4],
            [Tras1,Tras2,Tras3,Tras4],
            [Esq1,Esq2,Esq3,Esq4],
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
            [Dir3, Dir1,Dir4,Dir2],
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
            [Frente3,Frente1,Frente4,Frente2],
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



%Não genérico, funcionará apenas em cubos 2x2
%pois a soma máxima dos valores é 4
%e o máximo seria 2 com 2 quadrados por lado
avaliador(2, _, Valor):-
    Valor is 0,
    !.
avaliador(_,1,Valor):- 
    Valor is 0,
    !.
avaliador(_, Max, Max).


cabeca_calda(X, [X|Y], Y).
maximo(X, [X|[]]).
maximo(X, [Y|L1]):- maximo(X,L1), X>Y, !.
maximo(Y, [Y|_]).

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

atribui(X,X).
estendeCubo([_,[L1,L2,L3,L4,L5,L6]], CaminhosGerados):-
    cimaHorario([L1,L2,L3,L4,L5,L6], Cubo1),
    contaCubo(Cubo1, Valor1),
    cimaHorario(Cubo2, [L1,L2,L3,L4,L5,L6]),
    contaCubo(Cubo2, Valor2),
    direitaHorario([L1,L2,L3,L4,L5,L6], Cubo3),
    contaCubo(Cubo3, Valor3),
    direitaHorario(Cubo4, [L1,L2,L3,L4,L5,L6]),
    contaCubo(Cubo4, Valor4),
    frenteHorario([L1,L2,L3,L4,L5,L6], Cubo5),
    contaCubo(Cubo5, Valor5),
    frenteHorario(Cubo6, [L1,L2,L3,L4,L5,L6]),
    contaCubo(Cubo6, Valor6),
    atribui(CaminhosGerados, [
		[Valor1,Cubo1],
		[Valor2,Cubo2],
		[Valor3,Cubo3],
		[Valor4,Cubo4],
		[Valor5,Cubo5],
		[Valor6,Cubo6]]).


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

maior([F1|_],[F2|_]) :- F1 < F2.



%Definir o nó (estado) objetivo
objetivo(24).

%HILL CLIMBING
%Definir o nó (estado) objetivo
objetivo(f).

%HILL CLIMBING

hillClimbing([[H, Cubo]|_], [H, Cubo]):-	
	objetivo(H), !.
	%reverse([No|Caminho], Solucao).


hillClimbing([Cubo|Cubos], Solucao) :-
	estendeCubo(Cubo, NovosCubos),
    ordena(NovosCubos, CubosOrd),
    append(CubosOrd, Cubos, Cubos2),
    hillClimbing(Cubos2, Solucao).






