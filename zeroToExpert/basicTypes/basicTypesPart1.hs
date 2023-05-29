-- BASIC TYPES

-- BOOLEANS; Bool
-- Integers: Int, Integer
-- Reals: Float, Double
-- Characters: Char

-- Bool:
-- Literals: False / True
  -- not :: Bool -> Booleans       - negation
  -- (||) :: Bool -> Bool -> Bool  - disjunction
  -- (&&) :: Bool -> Bool -> Bool  - conjunction
  
-- INTEGERS:
  -- Int: Integers for 64 bits
  -- Integers: Integers (arbitrarily long)
-- Literals: 15, (-22), 8573263548732452644468 (Integer since its more than 64 bits)
-- Operations: +,-,*,div,mod,rem,^ NOTE: div is integer division and ^ is integer exponentiation
-- Relational Operators: <,>,<=,>=,==,/= --NOTE the difference of haskell /= and other langs !=

-- REALS
-- Type:
  -- Float: 32-bit floating-point reals
  -- Double: 64-bit floating-point reals
-- Literals: 3.14,1e-9,-3.0
-- Operations: +,-,*,/,** NOTE: / is real division, and ** real exponentiation
-- Relational Operators: <,>,<=,>=,==,/=
-- Integer to Real conversion: fromIntegral
-- Real to Integer conversion: round, floor, ceiling (of course with there slight differences




main = do
  print $ "BOOLEANS:"
  print $ not True
  print $ not False
  print $ True || False
  print $ True && False
  print $ (False || True) && True
  print $ not (not True)
-- print $ not not True -- this errors because haskell reas (not not) True as functions have the 
-- highest precedence.
  print $ "======================================================="
  print $ "INTEGERS:"
  print $ 3+4*5
  print $ (3+4)*5
  print $ 2^10
  print $ 3+1/=4
  print $ 11/2 -- real division
  print $ div 11 2 -- integer division
  print $ mod 11 2 -- mod is always greater than or equal to 0. ABS result or Euclidian modal
  print $ rem 11 2 -- remainder takes the sign of the dividend
  print $ mod (-11) 2
  print $ rem (-11) 2
  print $ "======================================================"
  print $ "REAL NUMBERS:"
