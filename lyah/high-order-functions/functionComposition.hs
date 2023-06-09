-- FUNCTION COMPOSITION -- this is defined in practice (math & haskell) as composing two functions
-- so that given one argument, one function takes the argment and returns a result which is used
-- as the argument of the next associated function. In haskell we do this with the '.' (dot) function.

-- (.) :: (b -> c) -> (a -> b) -> a -> c -- takes functions b->c and a->b and an arg of type a
-- and returns a value of type c. Not the order of the letters which gives us an idea of the
-- path running this funtion takes. first (a -> b) takes a and returns function b, that that goes
-- into function (b -> c) which is what returns c. So in total a is converted to c after moving 
-- through all the different functions. 
-- f . g = \x -> f (g x) -- a lambda that's going to take two funcs (f & g) and run f on the result
-- of g x

-- One of the uses of function composition is for making functions on the fly to pass to other functions
-- We could use lambdas for that but there are times where . is more clear and concise. Let's look
-- at an example. Here is a list of numbers and we want to turn them all into negatives
-- we could do:
main = do
  print $ map (\x -> negate (abs x)) [5,-3,-6,7,-3,2,-19,24]
-- we could also do:
  print $ map (negate . abs) [5,-3,-6,7,-3,2,-19,24]
-- Because . is right associate just like $ we can compose many functions at a time
-- NOTE: right-associative: In programming languages the associativity of an operator is aa property
-- how operators of the same precedence are grouped in the ABSENCE of ()s. o sea, in what order each
-- operator is evaluated. So left-associative means that we evaluate the operators or functions of
-- the same precedence from left to right, and then of course right-associative means that we do this
-- from right ot left. That's why $ can help remove ()s and . can compose many functions. a simple
-- example:
-- left-associative: 3 - 2 - 1 = 0 -- cuz the left '-' is evaluated first
-- right-associative: 3 - 2 - 1 = 2 -- cuz the right '-' is evaluated first.


-- that's wy we can do things like turning this
  print $ map (\xs -> negate (sum (tail xs))) [[1..5],[3..6],[1..7]]
-- into
  print $ map (negate . sum . tail) [[1..5],[3..6],[1..7]]


-- NOTE that if we want to  use multiple params, we typically need to partially apply them down to 
-- taking only one argument. 
  print $ sum (replicate 5 (max 6.7 8.9))
  print $ (sum . replicate 5 . max 6.7) 8.9 -- so I think this is why we can't go overboard with the 
  -- $ and ., cuz when we are composing functions, there's need to be separation from the final args
  -- the new composed function is being used on. Otherwise haskell can't tell if you are trying to 
  -- run the composed function on that arg or include that arg as PART of the partially applied composed
  -- function. 
  
  -- If you want to replace a function with a lot of ()s with $ and . then you can do the following
  -- starting with putting the last param of the innermost function after a $ and than composing (.) 
  -- all the other function calls. this creates the separation of the comosed function from the final
  -- arg wee need above:
  print $ replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5][4,5,6,7,8])))
  -- can also be done this way:
  print $ replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8] --when using both
  -- . and $ we only use $ on the last arg to separate it from the composed and partially applied 
  -- functions. NOTE the first $ above is for the print, that's separating the entire result from the
  -- io function 'print' rather than putting it all in ()s
-- If the expression ends with three ()s, chances are that you can translate that into a function
-- composition with 3 composition operators.
  -----------------------------------------------------------
  -- The follow 3 runs are from the functions created at the bottom of the file. I had to bring them
  -- back up to main
  print $ oddSquareSum
  print $ oddSquareSum2
  print $ oddSquareSum3
  -- and they all work the same. 
  -----------------------------------------------------------


-- Another common use case for composition (.) is for 'so-called' point-free style (also called 
-- pointless style) :) 
sum' :: Num a => [a] -> a -- takes a list of type a of Num typeclass and returns a value a
-- sum' xs = foldl (+) 0 xs -- NOTE remember foldl recursion is out to the left and foldr recursion
  -- is out to the right of the binary function/operator.
  -- remember that if you have an arg exposed on both sides, due to currying you can remove it as 
  -- the resulting function will be one that takes that last arg removed.
sum' = foldl (+) 0 -- this style of removing args is call point free style. Let's try another one.

-- fn x = ceiling (negate (tan (cos (max 50 x))))
-- Here we have the 'x' on both sides of '=' , so we can get rid of it. But since he x in the body
-- is nested (has ()s after it) that last function call wouldn't make sense. But we can do this with
-- function composition (.) of partially applied functions. The difference as I understand it is that
-- the above is telling the function how to run or what to run first grouped in parens, but  when we
-- compose functions we are stepping back and simply saying what order it'll happen in but not 
-- necessarily the specific GROUPINGS of what must happen where and when. ???? Just a random thought
-- I'll clarify later.
fn = ceiling . negate . tan . cos . max 50 -- and that is point free programming which I think is very
-- close if not the same as tacit programming in langs like APL and J

-- Lots of times point-free is concise and more readable because it focuses on the functions and the 
-- functions that result by composing them together, rather than the data and how its shuffled around. 
-- You can make simple functions and use composition as glue to form more complex functions. 
-- NOTE: However, many times writing a function in point-free style can be LESS readable IF a function
-- is too complex. That's why making long chains of function composition is discouraged, although
-- we do see it in the wild. The preferred style is to use let bindings to give labels to intermediary
-- results or split the problem into sub-problems and then put it together so that the function makes
-- sense to someone reading it instead of just making a huge composition train. ;)

-- Let's finish this chap by redoing our oddSquareSum function (from maps & filters) in composition, as
-- well as with let/in

-- Original version from Maps & Filters
oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

-- Composed - we could have written it like this
oddSquareSum2 :: Integer
oddSquareSum2 = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

-- But if there's a chance someone else is reading your code or you are working in a team, its better
-- to stick to this:
oddSquareSum3 :: Integer
oddSquareSum3 = 
  let oddSquares = filter odd $ map (^2) [1..]
      belowLimit = takeWhile (<10000) oddSquares
  in sum belowLimit

-- the above is the most readable and you can basically read the declarative code and know what's 
-- happening without the need for comments even.
-- oddSquares run in the Main above
-- That's it for chap 6 - HIGHER ORDER FUNCTIONS. ;) 
 
