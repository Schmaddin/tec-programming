/*f(a,b)=..A.   =>  A = [f, a, b].
A = ..[f,a,b].  => A = f(a, b).
ༀ4 ?- A=..[f,a,b],call(A).
ERROR: '<meta-call>'/1: Undefined procedure: f/2

22. projekt
list -> arbol
AVL tree
*/
replace2(X,Y,Z,W):-(X==Z-> W is Y; W is Z).

myMapList(_,[],[]).
myMapList(G,[H|T],[R|T2]):-
G =..[Func|Params],
append(Params,[H,R],NewParams),
Pred =..[Func|NewParams],
call(Pred),
myMapList(G,T,T2).

myMap(_,[],[]).
myMap(Goal, [Element|Tail],[Element2|Tail2]) :-
Goal=..[Functor|Params],
append(Params,[Element,Element2],NewParams),
Pred=..[Functor|NewParams],
call(Pred),
myMap(Goal,Tail,Tail2),!.

tree(_,empty,empty).

insert(Num,empty,tree(Num,empty,empty)).
insert(Num,tree(Element,Left,Right),tree(Element,NewLeft,Right)):-Num<Element,insert(Num,Left,NewLeft).
insert(Num,tree(Element,Left,Right),tree(Element,Left,NewRight)):-insert(Num,Right,NewRight).


listInsertR([],tree(_,_,_)).
listInsertR([H],X):-insert(H,empty,X).
listInsertR([H|T],B):-listInsertR(T,A),insert(H,A,B).


listInsert(List,Result):-reverse(List,Reversed),listInsertR(Reversed,Result).

inorderR(tree(X,L,R), List):-(L==empty),(R==empty),append([X],[],List).
inorderR(tree(X,L,R), List):-(L\=empty),(R==empty), inorderR(L,OldList),append([X],OldList,List).
inorderR(tree(X,L,R), List):-(L\=empty),(R\=empty), inorderR(L,OldList),append([X],OldList,ListT),inorderR(R,ListR),append(ListR,ListT,List).
inorderR(tree(X,L,R), List):-(L==empty),(R\=empty), inorderR(R,OldList),append(OldList,[X],List).
inorder(X,List):-inorderR(X,Reversed),reverse(Reversed,List).

preorderR(tree(X,L,R), List):-(L==empty),(R==empty),append([X],[],List).
preorderR(tree(X,L,R), List):-(L\=empty),(R==empty),preorderR(L,ListNew),append(ListNew,[X],List).
preorderR(tree(X,L,R), List):-(L==empty),(R\=empty),preorderR(R,ListNew),append(ListNew,[X],List).
preorderR(tree(X,L,R), List):-(L\=empty),(R\=empty),preorderR(L,ListNew1),preorderR(R,ListNew2),append(ListNew2,ListNew1,ListNew),append(ListNew,[X],List).
preorder(X,List):-preorderR(X,Reversed),reverse(Reversed,List).


postorder(tree(X, L, R), Xs):-
  postorder(L, Ls),
  postorder(R, Rs),
  append(Ls, Rs, Xs1),
  append(Xs1, [X], Xs).
postorder(empty, []).