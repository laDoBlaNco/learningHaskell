-- LYAH - Chap 6 - Only folds and horses

-- As we learn to think recursively, we note a common pattern emerge in which we start with a base case or 
-- edge case (empty list, 0, 1, etc) and then we use the (x:xs) pattern to do something to the first element 
-- and recurse through the tail of the list. So this pattern is so common that there are a couple of functions 
-- that encapsulate it for us. The are call 'folds' and work a lot like map and as I was thinking they are what 
-- you see as 'reduce' in other languages. So rather than returning a list, they return a single value.

-- It takes a binary function, a starting value (accumulator) and a list to "fold" up. The binary funtion takes 2 args
-- Its called with the accumulator and the first (or last) element and produces new accumulator. Then that binary function
-- is called on that new accumulator and the new first element (we say first element in the sense of (x:xs) recurively acting 
-- on the head of the tail). When we've walked to the who list, only the accumulator is left. 

-- Let's see the first one 'foldl' or left fold. It folds the list up from the left side. The binary func is applied between
-- the starting value and the head of the list. That produces a new accumulator and then the function is called on that accumulator
-- and the next element

-- Let's implement sum with foldl
sum' :: Num a => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

-- What's happening here:
-- (\acc x -> acc + x) This is our lambda function and it takes an accumulator (start value) and the head of our list x
-- so with 0 [3,5,2,1] as the args we get:
-- 0 + 3 [5,2,1]
-- 3 + 5 [2,1]
-- 8 + 2 [1]
-- 10 + 1 []
-- 11
-- So we can see how the left side accumulator kinda consumes or the list is folded into it. 
-- taking into consideration currying, we could actually implement this even shorter
sum2 = foldl (+) 0 -- since our lambda is the same as (+), just waiting for 2 args and then we pass it 0, so now its just waiting to consume a list.
-- which is what xs is in sum' 
-- NOTE: Generally if you function type is foo a = bar b a, then you can write it foo = bar b as that'll create a function waiting on 'a'

-- Let's do another example of foldl, implement elem
elem' :: Eq a => a -> [a] -> Bool
elem' y ys = foldl (\a x -> if x==y then True else a) False ys

-- Now let's look at the right fold which works the same way, except the accumulator eats up the values from the right. Also the left folds function has
-- the accumulator first and the list element second, and foldr has the list element first and the accumulator second. 
-- NOTE: Remember foldl accumulator on the left, foldr accumulator on the right. NOTE this is only
-- in the function definition. Using the function is the same format. 
-- foldr accFunc start list
-- foldl accFunc start list
-- foldr1 accFunc list
-- foldl1 accFunc list 

-- Also the accumulator result can be of any type. We've done numbers and bools, so now let's implement map and using an empty list
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x a -> f x : a) [] xs
-- I guess we are eating up the list from the back :) this time. and consing the result of f x to the front.
-- so it would make sense that I also NOTE that foldl starts at the beginning of the list and foldr starts at the back of the list?

-- So why would we want to do this with foldr, well thinking about map and building another list, we would need to use ++ to plug onto
-- the end and ++ is much more expensive then :, remember that ++ is O(n) and : is O(1) ;-)
-- so NOTE we usually use foldr if we are building up another list. 
-- you can reverse a list and then do the right fold just like the left fold. Also sometimes it doesn't matter, like with sum' it really 
-- don't matter what end we start at. 
-- One last thing, we can foldr an infinite list as we'll eventually hit the head, but we can't foldl an infinite list cuz we'll never get 
-- to the end.

-- NOTE: anytime you want to traverse a list element by element and return something based on that, chances are you want a fold. folds 
-- just like maps and filters are the key functions in fp.

-- A couple of related functions are foldl1 foldr1, these don't take an accumulator arg becasue its assumed that the first or last item of the list if the
-- accumulator and the fold on the second to first or last. 
-- With that in mind, we could make sum even shorter
sum3 = foldl1 (+) 

-- Something I learned from another source, which is really the same as above but makes more sense
-- in my head, is that foldr encapsulates the 'primitive recursion' pattern. So for example:
-- sum (x:xs) = x + sum xs - here primitive recursion is using the binary (+) with a constant value
-- on the left and the result of our function on the rest of the list on the right. With foldr
-- you provide the constant and the function and it does the exact same thing
-- sum = foldr 0 (+), In summary, as I'm still studying this, we see that the variations of folding
-- all encapsulate recursion models

-- Here are some examples of haskell library functions, implemented with folds
maximum' :: Ord a => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc)[]

product' :: Num a => [a] -> a
product' = foldr1 (*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)

-- Another other way to think about folds is for example: foldr:
-- If we have a binary function f and starting value z, and we are working with [3,4,5,6]. 
-- Basically we are doing f 3 (f 4 (f 5 (f 6 z))). So if the f = + and z = 0
-- 3 + (4 + (5 + (6 + 0))) or thinking in prefixes (+) 3 ((+) 4 ((+) 5 ((+) 6 0))) 

-- for a flodl: Using the same parts (+) 0 [3,4,5,6]
-- (+) ((+) ((+) ((+) 0 3) 4) 5) 6  

-- There is another set of basic functions that use the primitive recursion patterns (scanl,scanr)
-- They basically work the same but they report out on all the intermediate acc states in the form
-- of a list. And scanl1 & scanr2 do the same as foldl1 and foldr1
-- examples below in main - NOTE when using scan, the final result will either be the very first or
-- or last item in the list.

-- Scans are used to monitor the progression of our function. With scans we an answer questions like:
-- How many elements does it take for the sum of the roots of all natural numbers to exceed 1000?
-- The square roots of all natural nums is easy 'map sqrt [1..]' and then to get the sum, we can
-- use a fold, but to see it and know how many sums are under 1000 we can use a scan. 
sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1 -- we add 1 cuz we use scanl1
-- and it starts on the 2nd element.

-------------------------------------------------
-- MAIN
-------------------------------------------------
main = do
    print $ "Chap 6 - Only Folds and Horses"
    print $ sum' [3,5,2,1]
    print $ sum2 [3,5,2,1]
    print $ elem' 28 [45,69,44,33,67,28,32,658]
    print $ elem' 28 [45,69,44,33,67,29,32,658]
    print $ map' (+3) [1,2,3]
    print $ sum3 [3,5,2,1]
    print $ scanl (+) 0 [3,5,2,1]
    print $ scanr (+) 0 [3,5,2,1]
    print $ scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]
    -- so this is a way for us to get introspection in our folds, watching how the accumulator
    -- changes on each arg.
    print $ scanl (flip (:)) [] [3,2,1]
    print $ sqrtSums
    print $ sum (map sqrt [1..131])
    print $ sum (map sqrt [1..130])
 
    
