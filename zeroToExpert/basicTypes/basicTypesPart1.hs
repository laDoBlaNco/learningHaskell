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
  -- NOTE: something to note about haskell's round. Though it works normally for using the .5 as the
  -- middle mark to decide round up or down, when its right in the middle, o sea exactly .5 then haskell
  -- will go to the nearest EVEN number.


-- CHAR
-- Literals: 'a','A','\n'
-- Relational Operators; <,>,<=,>=,==,/=
-- Conversion functions (need to import Data.Char)
  -- ord :: Char -> Int
  -- chr :: Int -> Char
import Data.Char
 
 


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
  print $ round 3.6
  print $ round (-3.6)
  print $ map round [3.5,4.5,5.4,6.6]
  print $ map ceiling [2.1,2.2,2.6,2.9]
  print $ map floor [2.1,2.2,2.6,2.9]
  print $ 10.0/3.0
  print $ 10/3
  print $ 2.0**3.0
  print $ 2**3
  print $ fromIntegral 4
  print $ "======================================================"
  print $ "CHARS:"
  print $ ord '6'
  print $ chr 66
  print $ "======================================================"
  print $ "SOME PREDEFINED FUNCTIONS:"
  print $ even 66
  print $ odd 66
  print $ min 66 69
  print $ max 66 69
  print $ gcd 144 12
  print $ lcm 144 12
  print $ abs (-45)
  print $ sqrt 12
  print $ log 144
  print $ exp 12
  print $ cos 100
