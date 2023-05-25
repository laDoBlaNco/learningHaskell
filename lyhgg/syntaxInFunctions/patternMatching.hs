-- Pattern matching consists of specifying patterns to which some data should conform and then
-- checking to see if it does and deconstructing the data according to those patterns.

-- You can pattern match on any data type. you define separate function bodies for diff patterns.
lucky :: (Integral a)=>a->String
lucky 7 = "LUCKY NUMBER SEVEN!" -- matches specifically the number 7
lucky x = "Sorry, you're out of luck, pal!" -- matches any integral value

-- so it looks like the order of the patterns matters. o sea if 'lucky x' was first it would 
-- cover everything.
-- Its checked top to bottom, so its kinda like an open case statement

sayMe::(Integral a)=>a->String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- again moving that last pattern to the top would move the catch-all to the top and it would always
-- return the same answer "Not between 1 and 5". The compiler will compile it, but it'll call out
-- that its redundant.

-- here's a recursive factorial with pattern matching
factorial :: (Integral a) => a -> a -- receives an integer a and returns an integer a
factorial 0 = 1 -- first case takes 0 and returns 1
factorial n = n * factorial (n - 1) -- recursively takes n and returns n-1 * fatorials

-- Recursion is super important in haskell but we'll take a look at that later. 

-- When making patterns we need to make sure we have a catch-all pattern or we'll get a complaint 
-- about our patterns being 'Non-exhaustive'

-- what if we were adding together points on a grid?
-- w/out pattern matching:
addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a) -- get a pair of numbers then another pair of numbers
-- and returns a pair of numbers. 
addVectors a b = (fst a + fst b, snd a + snd b) 

-- But now with pattern matching
addVectors' :: (Num a) => (a,a)->(a,a)->(a,a) -- this stays the same
addVectors' (x1,y1) (x2,y2) = (x1 + x2,y1+y2) -- change the pattern to cover x1 & x2, y1 & y2

-- with patterh matching we can even create our ow versions or extensions of functions
-- for example fst and snd for triples
first::(a,b,c)->a -- takes a (a,b,c) tuple and returns the type a element
first (x,_,_) = x -- using the _ in the pattern meaning, we don't care what they are

second::(a,b,c)->b
second (_,y,_) = y -- NOTE that this doesn't have to be y. I can use anything, even still x if I want

third::(a,b,c)->c
third (_,_,z) = z

-- we can even pattern math in list comps
xs = [(1,3),(4,3),(2,4),(5,3),(5,6),(3,1)] -- if a match fails, it'll just move on to the next
res = [a+b|(a,b)<-xs]

-- something we'll see a lot with pattern matching is x:xs which matches the head and tail of a list
-- it will only match on a list with 1 or more items. or for binding the first 3 elements and
-- the rest of the list x:y:z:zs 

-- Now we can create our own implementation of the 'head' function
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!" -- our first use of 'error'
head' (x:_) = x -- we need to use () due to _. 

-- another exampple:
tell::(Show a)=>[a]->String -- take list of type a of the Show typeclass and return a String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x 
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y
-- NOTE that this works because we account for the [] on the end. Also, we don't need to use
-- (x:y:[]) for example we could remove the () and use the syntatic sugar [x,y]

-- Let's try a recursive pattern matching version o flength
length'::(Num b)=>[a]->b
length' [] = 0
length' (_:xs) = 1 + length' xs -- recursively match the tail on each run, return 1 and then + them up

-- let's do sum
sum'::(Num a)=>[a]->a
sum' [] = 0
sum' (x:xs) = x + sum' xs -- similar but here we use the head, returning it + the rest of the list
-- it'll go down the hole till it gets to 0 then add them all back up. This is truely recursive
-- because its waiting on all functions before it can do more work, saving in memory

-- AS PATTERNS - breaking something up accordng to a pattern and binding it to names whilst keeping
-- the reference to the whole thing. We do this with '@'. O sea we can match the pattern as normal
-- but we can always go back to reference the entire argument in the function. So below, even though
-- we've broken up "Kevin" to "K" "evin", in the boddy we can still reference "Kevin" in the 'all'
-- var.
capital::String->String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

-- NOTE: last thing to remember here for now, '++' can't be used in matches.


