fib(0,0).
fib(1,1).
fib(N,Sol):- N1 is N - 1, N2 is N - 2 , fib(N1,Sol1), fib(N2,Sol2), add(Sol1,Sol2,Sol).

succ2(0,0).
succ2(1,0).
succ2(N,N2):-succ(N1,N), succ(N2,N1).

add(X,Y,Z):-Z is X + Y.

fib2(0, 0).
fib2(X, Y):- X > 0, fib2(X, Y, _).

fib2(1, 1, 0).
fib2(X, Y1, Y2) :- X > 1,
             X1 is X - 1,
             fib2(X1, Y2, Y3),
             Y1 is Y2 + Y3.



collectFib(_,0,[]).
collectFib(N,S,List):- fib2(N,X), append(X,List1,List), N1 is N+1, succ(S,S1), collectFib(N1,S1,List1).



  move(1,X,Y,_) :-  
        write('Move top disk from '), 
        write(X), 
        write(' to '), 
        write(Y), 
        nl. 
    move(N,X,Y,Z) :- 
        N>1, 
        M is N-1, 
        move(M,X,Z,Y), 
        move(1,X,Y,_), 
        move(M,Z,Y,X).