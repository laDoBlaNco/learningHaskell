-- DEFINITION WITH PATTERNS

-- Functions can and are normally defined with patterns:
-- here below we define factorial with patterns instead of if/else
factorial :: Integer -> Integer -- calculates the factorial of a natural number
factorial 0 = 1  -- base case (edge case) - this must always come first in order
factorial n = n * factorial (n-1) -- recursive case
-- The evaluation of the patterns is from top to bottom and returns the result of the first
-- matching branch.

-- Patterns are considered more elegant than the if/else and they have many more applications.

-- '_' represents an anony var (there is no relation between different _ anony vars)
-- we use this when we don't care about the value and don't use it
nand :: Bool -> Bool -> Bool
nand True True = False
nand _ _ = = True -- we don't care about any other combination (True,False or False,False or False, True)

