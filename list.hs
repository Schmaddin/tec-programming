bigger :: (Double,Double) -> Double
bigger(a,b) = if a > b 
			  then a
			  else b
smaller :: (Double,Double) -> Double
smaller(a,b) = if a < b 
			   then a
			   else b

maxi :: [Double] -> Double
maxi [] = -1
maxi (x:[])=x
maxi (a:b:c) = if c == []
			  then bigger(a,b)
			  else maxi([bigger(a,b)]++c)

mini :: [Double] -> Double
mini [] = -1
mini (x:[])=x
mini (a:b:c) = if c == []
			  then smaller(a,b)
			  else mini([smaller(a,b)]++c)

maxmin :: [Double] -> (Double,Double)
maxmin list = (mini list,maxi list)	



helpMaxTuples :: ([[Double]],[(Double,Double)]) -> ([[Double]],[(Double,Double)])
helpMaxTuples(a:as,b) = helpMaxTuples(as,b++[maxmin a])
helpMaxTuples([],b) = ([],b)

tupleExtractor :: ([[Double]],[(Double,Double)]) -> [(Double,Double)]
tupleExtractor(a,b) = b

maxMinTupleList :: [[Double]] -> [(Double,Double)]
maxMinTupleList list = tupleExtractor(helpMaxTuples(list,[]))

