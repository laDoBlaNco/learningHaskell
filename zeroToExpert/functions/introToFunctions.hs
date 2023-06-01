-- Since Haskell is a pure functional language, functions are of course the vital piece of Haskell.

-- 1. Functions in Haskell are "pure": The are only pure if they return results caluclated relative
-- to their parameters.
-- 2. Functions do NOT have side effects:
  -- they do not modify the parameters
  -- they do not modify the memory
  -- they do not modify the input/output
-- 3. A function always returns the same result when applied to the same parameters.

-- 4. Functions always start with a lowercase letter. Upper case is reserved for types and typeclasses
  -- First we should create the type declaration (function header) (This is optional since haskell has
  ---- a great type inference engine.
  -- Then we give the definition, using format parameters. 
  
-- Examples:
  
double :: Int -> Int            -- calculate the double of a value
double x = 2 * x
  
perimeter :: Int -> Int -> Int  -- calculates the perimeter of a rectangle
perimeter w h = double (w+h)
  
xOr :: Bool -> Bool -> Bool     -- exclusive or (also call xor)
xOr a b = (a||b)&& not (a&&b) 

factorial :: Integer -> Integer
factorial n = if n == 0 then 1 else n * factorial (n-1) 


------------------------
-- MAIN
------------------------
main = do
  print $ double 33
  print $ perimeter 6 9
  print $ xOr (6>9) (9<6) 
  print $ factorial 5

  
