-- FUNCTION APPLICATION WITH $
-- Now let's look at the $ function, also called function application. 

-- ($) :: (a -> b) -> a -> b
-- f $ x = f x 
-- So $ is a binary function (operator). So what does this do? its just what it is, function application
-- Normal function applciation (space between two things) has the highest precedence, the $ function
-- has the lowest precedence. How is this so? function application with a space is
-- left-associative (so f a b c = ((f a) b) c, and function application with $ is
-- right-associative. 

-- So what does that all mean? Most of the time people just use it so you don't have to put 
-- ()s so sum (map sqrt [1..130]) == sum $ map sqrt [1..130] because $ has such low precedence.
-- When $ is found, the expr to the right is applied as the arg to the function on its left.
-- Below in main some examples




----------------------------------------------------------------------------
-- MAIN
----------------------------------------------------------------------------
main  = do
  print $ sqrt 3 + 4 + 9 -- adds 4 + 9 + the sqrt of 3. Remember that functions have precedence
  print $ sqrt (3 + 4 + 9) -- to get sqrt of sum you need ()s. Ok that i get.
  print $ sqrt $ 3 + 4 + 9 -- or you can use $ since $ has the lowest precedence of any operator.
  -- so its kinda like righting an open ( and then writing a closing one on the far right side.
  
  -- what about something more complex or nested
  print $ sum (filter (> 10) (map (*2) [2..10])) -- we can get rid of some of these ()s
  print $ sum $ filter (>10) $ map (*2) [2..10] -- so here we see nested ()s gone
  
  -- but apart of nixing ()s, this means that function application can be treated just like
  -- another function. So we can map function application over a list of functions
  print $ map ($ 3) [(4+),(10*),(^2),sqrt]
