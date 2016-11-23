tree(_,empty,empty).

insert(Num,empty,tree(Num,empty,empty)).
insert(Num,tree(Element,Left,Right),tree(Element,NewLeft,Right)):-Num<Element,insert(Num,Left,NewLeft).
insert(Num,tree(Element,Left,Right),tree(Element,Left,NewRight)):-insert(Num,Right,NewRight).


insertB(Num,empty,tree(Num,empty,empty)):-write("insert empty").
insertB(Num,tree(Element,Left,Right),Balanced):-Num<Element,insertB(Num,Left,NewLeft),b(tree(Element,NewLeft,Right),Balanced),write(" Insert Left: current dep: "),deep(tree(Element,NewLeft,Right),D),write(D).
insertB(Num,tree(Element,Left,Right),Balanced):-insertB(Num,Right,NewRight),b(tree(Element,Left,NewRight),Balanced),write(" insert Right: current dep: "),deep(tree(Element,Left,NewRight),D),write(D).

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


balance(tree(Num,Left,Right),Result):-deep(Left,L),deep(Right,R),diff(L,R,Diff),Diff > 1,balanceLeft(tree(Num,Left,Right),Result).
balance(tree(Num,Left,Right),tree(Num,NEW,Right)):-deep(Left,L),deep(Right,R),diff(L,R,Diff),Diff>2,balance(Left,NEW).
balance(tree(Num,Left,Right),tree(Num,NEW,Right)):-deep(Left,L),deep(Right,R),diff(L,R,Diff),Diff>0,balance(Left,NEW).
balance(tree(Num,Left,Right),tree(Num,Left,NEW)):-deep(Left,L),deep(Right,R),diff(L,R,Diff),Diff< -2,balance(Right,NEW).
balance(tree(Num,Left,Right),Result):-deep(Left,L),deep(Right,R),diff(L,R,Diff),Diff< -1,balanceRight(tree(Num,Left,Right),Result).
balance(tree(Num,Left,Right),tree(Num,Left,NEW)):-deep(Left,L),deep(Right,R),diff(L,R,Diff),Diff< 0,balance(Right,NEW).
balance(In,In).

orderedInsert(Num,Tree,Result):-insert(Num,Tree,ResultUnbalanced),balance(ResultUnbalanced,Result).

greater(A,B,A):-A>B.
greater(A,B,B).

diff(A,B,C):- C is A - B.
isSame(A,B):- A == B.
same(Tree,Tree).

balanceLeft(tree(M,tree(K,UL,UR),Right),Result):-deep(UL,L),deep(UR,R),diff(L,R,Diff),Diff>0,rightRotation(tree(M,tree(K,UL,UR),Right),Result).
balanceLeft(tree(M,tree(K,UL,UR),Right),Result):-deep(UL,L),deep(UR,R),diff(L,R,Diff),Diff<0,rightLeft(tree(M,tree(K,UL,UR),Right),Result).

balanceRight(tree(M,Left,tree(K,UL,UR)),Result):-deep(UL,L),deep(UR,R),diff(L,R,Diff),Diff<0,leftRotation(tree(M,Left,tree(K,UL,UR)),Result).
balanceRight(tree(M,Left,tree(K,UL,UR)),Result):-deep(UL,L),deep(UR,R),diff(L,R,Diff),Diff>0,leftRight(tree(M,Left,tree(K,UL,UR)),Result).

leftRotation(tree(X,Z,tree(K,L,M)),tree(K,tree(X,Z,L),M)).

rightRotation(tree(X,tree(K,L,M),Z),tree(K,L,tree(X,M,Z))).

leftRight(tree(A,H,tree(C,tree(B,D,E),F)),tree(X,Y,Z)):-rightRotation(tree(C,tree(B,D,E),F),tree(K,L,M)),leftRotation(tree(A,H,tree(K,L,M)),tree(X,Y,Z)).

rightLeft(tree(A,tree(C,F,tree(B,D,E)),H),tree(X,Y,Z)):-leftRotation(tree(C,F,tree(B,D,E)),tree(K,L,M)),rightRotation(tree(A,tree(K,L,M),H),tree(X,Y,Z)).
