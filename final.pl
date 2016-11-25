tree(_,empty,empty).



sortH(tree(X,empty,empty),tree(X,empty,empty)).
sortH(tree(X,tree(LH,LL,LR),empty),tree(X,Result,empty)):-X >= LH,sortH(tree(LH,LL,LR),Result).
sortH(tree(X,tree(LH,LL,LR),empty),tree(LH,Result,empty)):-X < LH,sortH(tree(X,LL,LR),Result).

sortH(tree(X,empty,tree(RH,RL,RR)),tree(X,empty,Result)):-X >= RH,sortH(tree(RH,RL,RR),Result).
sortH(tree(X,empty,tree(RH,RL,RR)),tree(RR,empty,Result)):-X < RH,sortH(tree(X,RL,RR),Result).


sortH(tree(X,tree(LH,LL,LR),tree(RH,RL,RR)),tree(X,LResult,RResult)):-  X >= LH,X >= RH,sortH(tree(LH,LL,LR),LResult),sortH(tree(RH,RL,RR),RResult).
sortH(tree(X,tree(LH,LL,LR),tree(RH,RL,RR)),tree(LH,LResult,RResult)):-  X < LH,LH >= RH,sortH(tree(X,LL,LR),LResult),sortH(tree(RH,RL,RR),RResult).
sortH(tree(X,tree(LH,LL,LR),tree(RH,RL,RR)),tree(RH,LResult,RResult)):-  X < RH,RH >= LH,sortH(tree(LH,LL,LR),LResult),sortH(tree(X,RL,RR),RResult).

sortIt(I,O):-sortH(I,O),sorted(O).
sortIt(I,O):-sortH(I,O1),sortIt(O1,O).

sorted(tree(X,empty,empty)).
sorted(tree(X,tree(LH,LL,LR),empty)):-X >= LH,sorted(tree(LH,LL,LR)).
sorted(tree(X,empty,tree(RH,RL,RR))):-X >= RH,sorted(tree(RH,RL,RR)).
sorted(tree(X,tree(LH,LL,LR),tree(RH,RL,RR))):-X >= RH,X >= LH,sorted(tree(RH,RL,RR)),sorted(tree(LH,LL,LR)).

number(empty,0).
number(tree(_,empty,empty),1).
number(tree(_,Left,empty),Length):-number(Left,LengthB),Length is LengthB+1.
number(tree(_,empty,Right),Length):-number(Right,LengthB),Length is LengthB+1.
number(tree(_,Left,Right),Length):-number(Left,L1),number(Right,R1), Length is R1+L1+1.

insertHeap(New,Tree,Result):-insertH(New,Tree,ResultPart),sortIt(ResultPart,Result).

insertH(Tree,empty,Tree).
insertH(tree(Num,empty,empty),tree(X,empty,empty),tree(X,tree(Num,empty,empty),empty)).
insertH(tree(Num,empty,empty),tree(X,L,empty),tree(X,L,tree(Num,empty,empty))).
insertH(tree(Num,empty,empty),tree(X,L,R),tree(X,Result,R)):-number(L,L1),number(R,R1),print(L1),print(R1),L1 =:= R1,insertH(tree(Num,empty,empty),L,Result).
insertH(tree(Num,empty,empty),tree(X,L,R),tree(X,Result,R)):-number(L,L1),number(R,R1),print(L1),print(R1),L1 =:= (R1+1),print("L1==R1+1"),insertH(tree(Num,empty,empty),L,Result).
insertH(tree(Num,empty,empty),tree(X,L,R),tree(X,L,Result)):-number(L,L1),number(R,R1),L1 > (R1+1),insertH(tree(Num,empty,empty),R,Result).
