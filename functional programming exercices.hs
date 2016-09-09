import Data.Char (digitToInt)
import Data.List (tails, (\\))
import Data.List (sort)

-------the calculations are somewhat expensive, please try with small numbers firsta
---Martin  & Emillio

-- tarea 1 : llama "lcmList [1..20]"
lcmList (a:[]) = a
lcmList (a:b:[]) = lcm a b
lcmList (a:b:c) = lcm a (lcmList(b:c))



-- tarea 2 : llama "primeAtPoint n"
testPrime a 1 = True
testPrime a b = if mod a b == 0 then False
                                else testPrime a (b-1)

isPrime a = testPrime a (a-1)

nextPrime a = if isPrime (a+1) == False then nextPrime (a+1) 
			                        else a+1
									
nextPrimeN a n = if n == 0 then a
				 else nextPrimeN (nextPrime a) (n-1)

primeAtPoint 0 = 0				 
primeAtPoint n = nextPrimeN 2 (n-1)


-- tarea 3  :  llama "findNumberCircular Number"								   
sortedPermutations number = sort (permutations number)
permutations :: Integer -> [Integer]
permutations n = take l $ map (read . take l) $ tails $ take (2*l -1) $ cycle s
    where
        s = show n
        l = length s

checkListForPrime ([]) = True
checkListForPrime (a:[]) = if isPrime a then True
				 else False
checkListForPrime (a:b) = if isPrime a then checkListForPrime b
                 else False
				 
checkInList list ([]) = False
checkInList list (a:b) = if a == list then True
                         else checkInList list b


findNumberCircular toN = findNumberCircularN toN 2 0 []
findNumberCircularN toN incrementCounter current permuList = if incrementCounter < toN && (checkListForPrime(permutations incrementCounter)) && (checkInList (sortedPermutations incrementCounter) permuList) == False then findNumberCircularN toN (incrementCounter+1) (current+1) ([sortedPermutations incrementCounter]++permuList) 
                                                             else if incrementCounter >= toN  then current 
              								                 else findNumberCircularN toN (incrementCounter+1) current permuList
															 
															 
--tarea 4: llama "primeSumUnder Number"

primeSumUnder max = primeSumUnderA max 2 2
				 
primeSumUnderA max lastprime sum = if (nextPrime(lastprime)+sum) >= max then sum
                                   else primeSumUnderA max (nextPrime lastprime) (sum+(nextPrime lastprime))	
			 