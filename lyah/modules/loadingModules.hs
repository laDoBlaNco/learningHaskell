-- Haskell modules are like Go modules, a collection of related functions, types and typeclasses. A
-- program is a collection of modules where the main module loads up the others and then uses the
-- funcs in them to do stuff. If a module is generic enough it can be used in multiple programs as
-- they are loosely coupled. 

-- Even the haskell standard lib is broken up into modules. There's a module for manipulating lists
-- for concurrent programming, for dealing with complex numbers, etc. Everything we've done so far has
-- been done with the Prelude module which is imported by default. here we are going to touch on some
-- other useful modules and the functions that they have. 

-- First let's see how we import modules. imports must be done before any function definitions, so we
-- typically put them at the top of the file. 
import Data.List

numUniques :: Eq a => [a] -> Int
numUniques = length . nub -- some function composing here with length and nub. These seems like
-- point-free style, as I don't see any arguments, just function composition.
-- the above creates a function equal to \xs -> length (nub xs) 

-- we can also import modules in the following ways:
  -- If we want specific functions from a module: import Data.List (nub,sort)
  -- if we want all but specific functions: import Data.List hiding (nub)
  -- if we want to avoid name clashes and call functions like Data.Map.filter: import qualified Data.Map
  -- if we want to rename a qualified import to soemthing else: import qualified Data.Map as M
  ---- now we can sue M.filter
  
