-- now its coming together. the 'main = ....' is the same as func main{...}  in Go and other
-- langs. 🤯

main :: IO () 
main = putStrLn (greet "World") 
-- main string = "Hello " ++ string -- this would give us an error cuz we are changing main from being
-- an IO type

-- main functions loaded into ghci have some added values. For example:
    -- 1. they can be used as commands in GHCI, so they work with :main
    -- 2. the type is 'main :: IO ()' meaning that they are i/o functions and have no return values
    -- So I'll add that type dec above it

-- we can though define other functions with here that interact with main of course
greet who = greeting ++ " " ++ who

-- we can also declare variables NOTE that declaration order doesn't matter here.
greeting = "Holis"

-- the process of updating the file and interacting it with :l (:load) and :r (:reload) is the 
-- typical development process for working in Haskell. We can also use :e (:edit) from within
-- ghci to open our editor.

-- Intro to Functions - functions in hs are very much mathy. This lang is all about equations
-- and definitions of mathematical functions

-- let's start with a simple funtion add
add :: Int -> Int -> Int
add a b = a + b -- though our script declares main above, when we load this is ghci we can access
-- all functions.

-- Haskell functions map from one value to another type of value. This can be 1 to 1 or multiple
-- items in tuples or list to one item. Or currying which is that the function takes its first
-- arg then returns a function that takes the second number and then does something with them.
-- this is why we have Int->Int->Int

-- Building your own types. 
-- simplest type is a 'synonym' using the type kw. Similar to Go's type aliases
-- You may want to refer to a certain type with a name that describes what it is
type Count = Int -- This doesn't though give us any more power, just a new name for an old type

processString::[Char]->Count
processString = undefined

-- For more power we can use algebraic datatypes
data Compass= North|South|East|West -- this looks like they are Go structs/types which would make
    deriving (Eq,Ord,Enum,Show)
-- the 'instances' I keep seeing the 'methods' in haskell
-- instance Show Compass where
    -- show North = "North"
    -- show South = "South"
    -- show East = "East"
    -- show West = "West"

-- Same exact concept as Go with Stringer interface here are the polymorphic variables and the
-- (constraints)=>. In Go for Stringer to work you need a struct type with a method String()
-- in haskell to Show (print) you need an instance for your data type of Show. Same stuff
-- different lang.
-- So now let's add some more instances. Everytime you try to run something and the error says
-- "There's no Instance for algo...." it menas there's no method created to do what you are asking
-- haskell to do on that type.
-- instance Eq Compass where
--     North==North = True

-- So how do we do this automatically? with Deriving. The haskell magic that works because
-- these basic instances are so mechanical. so just by adding 'deriving (...)' as above

-- NOTE; these are call algebraic types as they stand for something else. 'North|South' are
-- sum types (addition), which we've seen before in other langs. A kind of type switch interfacing. But
-- we  also have product types (multiplication), where the constructors take additional parameters.

-- let's do an example of types creating a basic calculator language: 
-- NOTE we start with the 'data' kw like in Go we would have type Name struct{} and everything
-- in haskell is in equation form
data Expression = Number Int
                | Add Expression Expression
                | Subtract Expression Expression
                deriving (Eq,Ord,Show) 
-- NOTE above the haskell form for creating a basic type. We use 'data' to start then the name
-- of the type and define it after '='. Then based on what we learned above, while 'Number Int' is
-- the actual type value, its methods or in haskellese it's 'class instances' are Add, Subtract, and
-- the derived classes we add of Eq,Ord,Show 

-- Pattern Matching
-- now we are going to create a function that'll do the calculations we need above.
calculate :: Expression -> Int -- this function takes an expression and returns an Int
calculate (Number x) = x
calculate (Add x y) = (calculate x) + (calculate y)
calculate (Subtract x y) = (calculate x) - (calculate y)

-- pattern matching on lists
newHead :: [a] -> a
newHead [] = error "empty list"
newHead (x:xs) = x

newTail :: [a] -> [a]
newTail [] = error "empty list"
newTail (x:xs) = xs
