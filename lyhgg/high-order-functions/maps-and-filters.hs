-- MAPS AND FILTERS 

-- the sig of map is map::(a->b) -> [a] -> [b]
-- so it takes a function and a list and returns another list
-- it is recursive as we see in the definition
map' :: (a->b)->[a]->[b]
map' _ [] = []
map' f (x:xs) = f x : map f xs -- recursive model run func on the head and then mapping the tail

-- map is very versatile and we can use it in a lot of different ways. See below in main
-- Most of what we did below main can be done with a list comp, but there are situations where
-- the map is more readable, such as nested lists and when only using a function on a list without any 
-- need for guards, filters, etc.

-- Now let's talk about some filters. A filter takes a pred and a list and then returns the list of elements
-- that satisfy the pred. Again, rolling my own below
filter' :: (a->Bool)->[a]->[a]
filter' _ [] = [] -- some pattern matching to take care of the empty [] case
filter' p (x:xs)  -- NOTE: remember that when we use guards we don't need to use '=' after the arg
    |p x = x:filter p xs -- run p on x and then cons x on the filter of the tail xs
    |otherwise = filter p xs -- catch-all to continue to filter xs
-- remember that guards are true false cases. So using a predicate on x will return True or False. If True then we 
-- already know that x will be added to the return list, if not, then it won't and it'll move on to the tail of the list.

-- Again, everything below could be done wtih list comps, but at times maps and filters are more readable.
-- For example, let's do our quicksort again in a more readable way:
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerSorted = quicksort (filter (<=x) xs)
        biggerSorted = quicksort (filter (>x) xs)
    in smallerSorted ++ [x] ++ biggerSorted

-- maps and filters are the bread and butter in every fp's toolbox. 
-- In an imperative lang this kinda stuff is done with nesting nested loops, etc. But with map and filter and haskell's laziness
-- even if you map something over a list several times and filter it several times, it will only pass over your list once.
-- for example, do this in an imperative lang:
largestDivisible :: Integral a => a -- takes no params
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829==0
-- since we are only asking for the head, haskell is going to stop after it gets the first element. 
-- Now let's try another one, but first here's 'takeWhile'
-- takeWhile takes a pred and a list and as long as the pred returns true it builds a new list from the old.
-- Example in main

-- Here's another contrived example to show the power of haskell's laziness. Using the collatz sequence
chain :: Integral a =>a->[a]
chain 1 = [1] -- our edge case
chain n
    |even n = n:chain (n `div` 2)
    |odd n = n:chain (n*3+1)

-- now the function that gives us the answer to our quesition
numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15
-- NOTE: This function has a type of numLongChains::Int because 'length' returns an Int instead of a Num a for
-- historical reasons. If we wanted to return a more general Num a, we could have used fromIntegral on the result


-- using map we can even do something like map (*)[0..] basically creating a list of partially applied
-- functions. 
listOfFuns = map (*) [0..] -- list is actually kinda insanely powerful. This is a black box of funcs
--- just waiting to be called, I just called index 153000 and it ran just as fast as if it was
-- the index 0



----------------------------------------
-- MAIN
----------------------------------------
main = do
    print $ map' (+3) [1,5,3,1,6] -- mapping a partically applied curried function here as well.
    print $ map' (++ "1") ["BIFF","BANG","POW"] -- NOTE: '++' concats to the end and : conses to the front of the list.
    print $ map' (replicate 3) [3..6] -- here we are techincally mapping a partially applied function (curried)
    print $ map' (map (^2)) [[1,2],[3,4,5,6],[7,8]] -- mapping a map, this must be done for nested lists
    print $ map' fst [(1,2),(3,5),(6,3),(2,6),(2,5)]
    print $ "----------------------------"
    print $ filter' (>3)[1,5,3,2,1,6,4,3,2,1]
    print $ filter' (==3)[1,2,3,4,5]
    print $ filter' even [1..10]
    print $ let notNull x = not (null x) in filter' notNull [[1,2,3],[3,4,5],[2,2],[],[],[]]
    print $ filter' (`elem` ['a'..'z']) "u LaUgH aT mE BeCaUsE I aM diFfeRent"
    print $ filter' (`elem` ['A'..'Z']) "i lauGh At You BecAuse u r aLL the Same"
    print $ largestDivisible 
    print $ sum (takeWhile (<10000) (filter odd(map (^2)[1..]))) -- so reading this from the back, we have an infinite list
    -- and we square every element, but we only want the odd ones and only those under 10000, and finally the sum
    -- this also coulda been a list comp
    print $ sum (takeWhile (<10000) [n^2|n<-[1..],odd(n^2)]) -- this is actually more readable for me.
    print $ "-------------------------------"
    print $ chain 10
    print $ chain 1
    print $ chain 30
    print $ numLongChains
    print $ (listOfFuns!!4)5
