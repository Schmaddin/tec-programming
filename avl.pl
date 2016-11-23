tree(_,empty,empty).

insert(Num,empty,tree(Num,empty,empty)).
insert(Num,tree(Element,Left,Right),tree(Element,NewLeft,Right)):-Num<Element,insert(Num,Left,NewLeft).
insert(Num,tree(Element,Left,Right),tree(Element,Left,NewRight)):-insert(Num,Right,NewRight).

deleteB(Num,tree(Num,empty,empty),empty).
deleteB(Num,tree(Num,Left,empty),Left).
deleteB(Num,tree(Num,empty,Right),Right).
deleteB(Num,tree(Num,Left,Right),Result):-succLeft(Right,X),deleteB(X,tree(Num,Left,Right),tree(NumNew,LeftNew,RightNew)),b(tree(X,LeftNew,RightNew),Result).
deleteB(Num,tree(Element,L,R),Result):-Num<Element,deleteB(Num,L,ResultT),b(tree(Element,ResultT,R),Result).
deleteB(Num,tree(Element,L,R),Result):-deleteB(Num,R,ResultT),b(tree(Element,L,ResultT),Result).
deleteB(Num,tree(Element,L,R),tree(Element,L,R)).

succLeft(tree(Num,empty,empty),Num).
succLeft(tree(Num,L,R),X):- L \= empty,succLeft(L,X).
succLeft(tree(Num,tree(Element,empty,_),Right),Element).


insertB(Num,empty,tree(Num,empty,empty)):-write("insert empty").
insertB(Num,tree(Element,Left,Right),Balanced):-Num<Element,insertB(Num,Left,NewLeft),b(tree(Element,NewLeft,Right),Balanced),write(" Insert Left: current dep: "),deep(tree(Element,NewLeft,Right),D),write(D).
insertB(Num,tree(Element,Left,Right),Balanced):-insertB(Num,Right,NewRight),b(tree(Element,Left,NewRight),Balanced),write(" insert Right: current dep: "),deep(tree(Element,Left,NewRight),D),write(D).

b(empty,empty).
b(tree(Root,L,R),Result):-deep(R,R1),deep(L,L1),L1-R1>1,subWeight(L,Sub),Sub<0,rightLeft(tree(Root,L,R),Result),write(" right-left Rotation? "),write(L1-R1).
b(tree(Root,L,R),Result):-deep(R,R1),deep(L,L1),L1-R1>1,rightRotation(tree(Root,L,R),Result),write(" right Rotation? "),write(L1-R1).

b(tree(Root,L,R),Result):-deep(L,L1),deep(R,R1),L1-R1< -1,subWeight(R,Sub),Sub>0,leftRight(tree(Root,L,R),Result),write(" left-right Rotation? "),write(L1-R1).
b(tree(Root,L,R),Result):-deep(L,L1),deep(R,R1),L1-R1< -1,leftRotation(tree(Root,L,R),Result),write(" left Rotation? "),write(L1-R1).

b(tree(Root,L,R),tree(Root,L,R)):-deep(R,R1),deep(L,L1),write("  leave it like it is  "),write(L1-R1).

deep(empty,0).
deep(tree(_,empty,empty),1).
deep(tree(_,Left,empty),Length):-deep(Left,LengthB),Length is LengthB+1.
deep(tree(_,empty,Right),Length):-deep(Right,LengthB),Length is LengthB+1.
deep(tree(_,Left,Right),Length):-deep(Left,L1),deep(Right,R1), greater(L1,R1,G), Length is G +1.

subWeight(tree(Root,L,R),X):-deep(R,R1),deep(L,L1),X is L1-R1.


greater(A,B,A):-A>B.
greater(A,B,B).


leftRotation(tree(X,Z,tree(K,L,M)),tree(K,tree(X,Z,L),M)).

rightRotation(tree(X,tree(K,L,M),Z),tree(K,L,tree(X,M,Z))).

leftRight(tree(A,H,tree(C,tree(B,D,E),F)),tree(X,Y,Z)):-rightRotation(tree(C,tree(B,D,E),F),tree(K,L,M)),leftRotation(tree(A,H,tree(K,L,M)),tree(X,Y,Z)).

rightLeft(tree(A,tree(C,F,tree(B,D,E)),H),tree(X,Y,Z)):-leftRotation(tree(C,F,tree(B,D,E)),tree(K,L,M)),rightRotation(tree(A,tree(K,L,M),H),tree(X,Y,Z)).
