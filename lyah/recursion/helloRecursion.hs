-- Recursion is important in Haskell cuz we do computations by declaring what something is
-- not declaring how to do it. There are no while loops or for loops. In Haskell we have to
-- use recursion to declare what something is.

--MAXIMUM AWESOME
maximum'::(Ord a)=>[a]->a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) -- splitting the head and tail with pattern matching is a very common idiom
    | x > maxTail = x
    |otherwise = maxTail
    where maxTail = maximum' xs 
-- pattern matching goes great with recursion. 

-- we could rewrite this using built-in 'max'
maximum2::(Ord a)=>[a]->a
maximum2 [] = error "maximum of empty list"
maximum2 [x] = x
maximum2 (x:xs) = max x (maximum2 xs) -- even shorter using haskells functions.

-- Let's look at some other recursive functions. Implementing them using recursive.
-- replicate'
replicate' :: (Num i,Ord i)=>i->a->[a] -- in haskell we don't have subclasses, its not OO
-- that's why we need both typeclasses (Num, Ord) because just because something is a Num doesn't
-- necessarily mean it can be ordered.
replicate' n x
    |n <= 0 = [] -- base case. Once n reaches 0 it'll return [] and then go up the ladder consing
    |otherwise = x:replicate'(n-1)x

-- here we used guards instead of patterns since we are testing for bool conditions <=

-- Now let's implement 'take'
take' :: (Num i,Ord i)=>i->[a]->[a]
take' n _
    |n<=0 = [] -- NOTE we used a guard with an 'otherwise'. so if it fails we fallthrough to the
    -- next pattern matching for take'
take' _ [] = []
take' n (x:xs) = x: take' (n-1) xs

-- Now with 'reverse'
-- here our recursive case will need to take on the end instead of the beginning with ++
reverse' :: [a]->[a]
reverse' [] = [] -- base case
reverse' (x:xs) = reverse' xs ++ [x]

-- repeat takes an element and returns an infinite list with that element
repeat'::a->[a]
repeat' x = x:repeat' x -- remember this ends in an infinite list of x. So we need to compose
-- it with someting else to stop the recursion. Like 'take'

-- Zip
zip'::[a]->[b]->[(a,b)] -- takes list of a and list of b and returns a list of a,b pairs
zip' _ [] = []
zip' [] _ = [] -- both base cases, if either list is empty
zip' (x:xs)(y:ys) = (x,y):zip' xs ys -- cons x,y and then cons that to the zip of xs and ys

-- Elem
elem'::(Eq a)=>a->[a]->Bool
elem' a [] = False
elem' a (x:xs)
    |a==x = True
    |otherwise = elem' a xs


-- QUICKSORT
quicksort::(Ord a)=>[a]->[a] -- takes an array of type a which much be an instance of ORD and returns 
-- an array of type a
quicksort [] = [] -- edge case or base case  is an []. sorting an [] gives you an []
quicksort (x:xs) =
    let smallerSorted = quicksort [a|a<-xs,a<=x]
        biggerSorted = quicksort [a|a<-xs,a>x]
    in smallerSorted ++ [x] ++ biggerSorted -- NOTE I tried to see if ':' would work for consing
    -- on the front of the list, but it doesn't because we are adding [a] ++ [x] ++ [a] and not
    -- a : [x] ++ [a] 

-- NOTE: The pattern:
    -- First you define the edge case
    -- Then you define a function that does something in between some element and the function
    --- applied to the rest of the list.
        -- Doesn't matter if its a list or a tree or any other data structure. A sum is the first
        --- element of a list plus the sum of the rest of the list. You want a product of a list,
        --- its the first element of the list times the product of the rest of the list. The lenght
        --- now, well, the length of a list is one plus the length of the rest of the list, etc. etc.
        
        -- The key is that they all have to have edge cases or base cases. The simplest result where
        --- recursion doesn't make sense anymore. For example in a list, the base case is an empty list
        --- for a tree, its the node that doesn't have any children, etc. Same is true with numbers. 
        --- The base case for numbers is typically the identity. For sums its 0, anything + 0 is itself
        --- for multiplication its 1, anything times 1 is itself. 

----------------------------------------------------------------
-- MAIN
----------------------------------------------------------------
main = do
    print $ maximum' [1,5,3,8,5,9]
    print $ maximum2 [56,34,132,5,7,11]
    print $ replicate' 10 "MM"
    print $ take' 3 [5,4,3,2,1] 
    print $ take' 0 [5,4,3,2,1] 
    print $ reverse' [1,2,3,4,5]
    print $ take 10 $ repeat 66
    print $ zip [1,2,3,4,5]["one","two","three","four","five","six","seven"]
    print $ elem 28 [1,54,78,69,28,56]
    print $ elem 28 [1,54,78,69,29,56]
    print $ quicksort [34,67,9,23,69,11,5,1]
    print $ quicksort "the quick brown fox jumps over the lazy dog"
