-- haskell is static typed, but uses an inference engine so that you don't always need to be
-- bothered by it. However, understanding the type system is a very important part of learning
-- Haskell

-- NOTE: in ghci we can use the :t command to find the type of anything, that's convenient

-- 'a' :: char reads 'a' has type of Char
-- NOTE that types start capital letters. 

-- one thing I noticed is that strings may come back as a list of chars [Char] or a string String
-- these are the same thing. 

-- also remember that with tuples, the length is also part of the type (True,'a') = (Bool,Char)
-- as it's type, and ('a','b','c') = (Char,Char,Char) as the type.

-- Functions have types as well. Again hs will infer but we can give them a type explicitly 
-- functionName :: argType -> returnType
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c|c<-st,c `elem` ['A'..'Z']]

-- now our function has a type of [Char]->[Char]. We could have also used [String]->[String] as 
-- they are the same, and it might be easier understood. Again, though this wasn't necessary
-- its a good idea to do this for clarity. Now what if we have several diff arg or Types
addThree::Int->Int->Int->Int -- function that takes 3 ints and return an int
addThree x y z = x+y+z

-- The return type is simply the last type in the chain. Everything else is an arg.
-- The separation of them with -> rather than ',' is also key, but we'll get to that later. 

-- NOTE: you can also use ghci :t with your function to see what hs says the declaration should be
-- and use or modify that (or check it)


-- Here's a list of the most common types:
    -- Int - ints typically bounded to -2147483648 to 2147483647 on 32bit machines
    -- Integer - same as above but for really big numbers as its not bounded.
factorial::Integer->Integer
factorial n = product [1..n] -- NOTE: check the reason later, but tabbing this in gives me an error,
                            -- as if functions must start at the left margin???
    
    -- Float - real floating point with single precision
circumference::Float->Float
circumference r=2*pi*r

    -- Double - real floating point with double precision
circumference'::Double->Double
circumference' r = 2*pi*r

    -- Bool - is the boolean type. It can only have two values: True and False
    -- Char - represents a character. Its denoted by single quotes. A list of chars is a string
    
    --Tuples are also types but they depend on the components, so there is theorectically an
    -- infinite number of tuple types, which is too many to cover here. NOTE: An () is also a 
    -- type which can only have a single value ().
    
-- TYPE VARIABLES
    -- when we check the :type of a generic function like 'head' we get head::[a]->a but what is
    -- 'a'. Its not a type cuz types have capital letters. Its actually a 'type variable'. This is
    -- haskell's version of generic types, only its much more powerful? These types of functions
    -- are called polymorphic and I remember hearing that when studying Odin lang. 
    -- Though type vars can have any name, we typically give them names a,b,c,d,.... such as 
    -- the 'fst' function. (fst::(a,b)->a. It takes a tuple and here a and b are just different 
    -- types. 
    
-- TYPE CLASSES 101
    -- these are kinda like interfaces that define behavior. These seems like interfaces in Go.
    -- If a type is part of a typeclass that means that it supports and implements the behavior
    -- contract, or job description that the typeclass describes. Just like Go, this is not
    -- Object Oriented talk. :type (==) is (==)::(Eq a) => a -> a -> Bool
    -- NOTE: 1. == is a function just like +,*,/,- and any other operator. If a function is just
    -- one special character then its an infix function by default. To analyze their types or pass
    -- to another function, we need to put them in ()s.. 
    --      2. We also see => which means 'class constraint', and again I'm reminded of Type Constraints
    -- in Go. 
    -- So (==)::(Eq a)=>a->a->Bool reads 'the equality function takes any two values that are of the
    -- same type 'a' and return a Bool. The type of those two values must be a member of the Eq class
    -- which is the 'class constraint'. That's what Eq a => means 
    
    -- The Eq typeclass provides an interface for testing equality. Any type where it makes sense to
    -- test between two values, should be a member of the  Eq class. All standard Haskell types except
    -- for IO are part of the Eq class. 
    
    -- Here's another one. elem :: (Foldable t, Eq a) => a -> t a -> Bool. This is a tricky one. ;-)
    -- Looks like it has  two class restraints. This much have changed cuz the book only shows
    -- elem::(Eq a)=> a -> [a] -> Bool which is a type in the Eq class used to check a list of the same
    -- type and returns a Bool. But the new signature has two typeclasses and one of them is Foldable.
    -- Foldable t must be speaking about the list. I'll come back to this later. 
    
    -- Some basic types. 
    -- 'Eq' is for anything that can be compared with == and /= (just like Go's Comparison restraint). So 
    -- if Eq is in the class restaint, than in its definition are == or /= somewhere. 
    
    -- 'Ord' is another one. This means ordering. These types must have an ordering.
    -- (>) :: Ord a => a -> a -> Bool. To be a member of the Ord class, a type must first have membership
    -- in the Eq club ;) 
    
    -- Member of the Show type class (Stringer in Go) can be presented as Strings. All types covered
    -- so far are part of  this club as well. The most used function that deals with 'Show' typeclass
    -- is 'show' which represents everything it can as a string.
    
    -- 'Read' is kinda the opposite of 'Show'. 'read' takes a string adn returns a type which is 
    -- a member of Read' if we use read with just one value such as read "4" we get an error
    -- because it doesn't know what to return. Its abigous. H doesn't know what what type we are 
    -- trying to work with. As opposed to this read "8.2" = 3.8 where it knows we are looking to get
    -- back a floating point number. To battle the ambiguity, we can use type notations
    -- read "4" :: Int, or read "5" :: float
    
    -- Enum members are sequentally ordered types. they can be enumerated. This typeclass is what
    -- means we can use its types in list ranges. the also have defined successors and predecesors. 
    -- which can be used with succ and pred
    
    -- Boundee members have an upper and lower bound. There type is (Bounded a) => a. All tuples
    -- are part of this class/family
    
    -- Num is the numeric typeclass. Its members have the property of being able to act like numbers
    -- :t of a 20 is (Num t) => t. They are also polymorphic constants. They can act like any type
    -- in the Num typeclass

    -- Integral is also a Numeric class. Num contains all numbers, including real numbers and integral numbers.
    -- Integral only includes integral whole numbers. 
    
    -- Finally Floating which includes the floating point numbers, so Float and Double

