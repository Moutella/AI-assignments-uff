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
    


%Função auxiliar para contar quantas casas 
%de cada cor há em um lado do cubo
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

%Caso 1: 2 lados possuem 2 casas de 2 cores, que está na restrição abaixo
%Caso 2: Se o maior valor for 1(4 cores diferentes no lado), não é para atribuir pontos
%Caso 3: Caso nenhum dos outros aconteça, 
%teremos 2, 3, ou 4 casas de uma cor,
%que é a pontuação deste lado
avaliador(2, _, Valor):-
    Valor is 0, !.
avaliador(_,1,Valor):- 
    Valor is 0, !.
avaliador(_, Valor, Valor).

%Máximo
maximo(X, [X|[]]).
maximo(X, [Y|L1]):- maximo(X,L1), X>Y, !.
maximo(Y, [Y|_]).

%Para cada lado com 2 cores iguais, associe 2 pontos; 3 cores iguais – 3
%pontos; 4 lados iguais – 4 pontos
%Restrição: se um lado tiver 2 faces de uma cor e 2 faces de outra cor, não
%pode somar 2 pontos
pontosLado(Vals, Valor):-
	count(Vals, 2, CoresComDois),
    maximo(MAX, Vals),
    avaliador(CoresComDois, MAX, Valor).
    
    

%Conta quantos casas de cada cor há neste lado
avaliaLado(Lado, Valor):-
    count(Lado, amarelo, ValorAmarelo),
    count(Lado, azul, ValorAzul),
    count(Lado, branco, ValorBranco),
    count(Lado, vermelho, ValorVermelho),
    count(Lado, laranja, ValorLaranja),
    count(Lado, verde, ValorVerde),
    pontosLado([
		ValorAmarelo, ValorAzul, ValorVermelho,
		ValorLaranja, ValorVerde, ValorBranco], Valor).


%Avalia o valor de cada lado, sendo o ValorCubo, a soma deles
avaliaCubo([L1,L2,L3,L4,L5,L6], ValorCubo):-
    avaliaLado(L1, Val1),
    avaliaLado(L2, Val2),
    avaliaLado(L3, Val3),
    avaliaLado(L4, Val4),
    avaliaLado(L5, Val5),
    avaliaLado(L6, Val6),
    ValorCubo is Val1+Val2+Val3+Val4+Val5+Val6.


%Append preguiçoso
atribui(X,X).
%Função que gera todos os próximos estados possíveis
estendeCubo([_,[L1,L2,L3,L4,L5,L6]], CubosGerados):-
    cimaHorario([L1,L2,L3,L4,L5,L6], Cubo1),
    avaliaCubo(Cubo1, Valor1),
    cimaHorario(Cubo2, [L1,L2,L3,L4,L5,L6]),
    avaliaCubo(Cubo2, Valor2),
    direitaHorario([L1,L2,L3,L4,L5,L6], Cubo3),
    avaliaCubo(Cubo3, Valor3),
    direitaHorario(Cubo4, [L1,L2,L3,L4,L5,L6]),
    avaliaCubo(Cubo4, Valor4),
    frenteHorario([L1,L2,L3,L4,L5,L6], Cubo5),
    avaliaCubo(Cubo5, Valor5),
    frenteHorario(Cubo6, [L1,L2,L3,L4,L5,L6]),
    avaliaCubo(Cubo6, Valor6),
    atribui(CubosGerados, [
		[Valor1,Cubo1],
		[Valor2,Cubo2],
		[Valor3,Cubo3],
		[Valor4,Cubo4],
		[Valor5,Cubo5],
		[Valor6,Cubo6]]).


ordena(Cubos,CubosOrd):-
	quicksort(Cubos,CubosOrd).

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
%O objetivo é o estado onde os 6 lados terão valor 4
objetivo(24).


%HILL CLIMBING
hillClimbing([[H, Cubo]|_], [H, Cubo]):-	
	objetivo(H), !.

hillClimbing([Cubo|Cubos], Solucao) :-
	estendeCubo(Cubo, NovosCubos),
    ordena(NovosCubos, CubosOrd),
    append(CubosOrd, Cubos, Cubos2),
	%print(CubosOrd),
    hillClimbing(Cubos2, Solucao).







