{-
    Haskell functions can take functions as params and return functions as return values. Any
    functions that can do that are called 'high-order' functions. High order functions aren't 
    just a part of the haskell experience, they pretty much ARE the haskell experience. It turns
    out that if you watn to define computations by defining what stuff IS instead of defining 
    steps that change some state and loop, high order functions are indispensable. They're really
    a powerful way of solving problems and THINKING about problems. And in my experience, not 
    only in hacking or tech. Really in thinking about any problem you need to solve in life. Its
    the functional way to live ;)
-}

-- CURRIED FUNCTIONS
-- NOTE: all functions in haskell officially only take 1 parameter. Even if they look like they 
--- take muliple and its due to a trick called 'curried functions'. For example 'max'. it looks
--- like it takes two params and gives back the largest. But in actuality 'max 4 5' creates another
--- function that takes only 1 param and returns either 4 or that param. So when it sees 5 then it
--- runs that function.
-- max 4 5 -> 5
-- (max 4) 5 -> 5 this works cuz (max 4) is the function that returns another function to take 5

-- Putting a space between two things is simply function application. Its like a space is an 
--- actual operator.

-- this max::Ord a => a -> a -> a can also be written like this max :: Ord a => a -> (a -> a)
-- which can be read as: max takes an a and returns (that's ->) a function that takes an a
-- and returns -> an a (a -> a). That's why everything returns everything with -> 

-- This means if we call a function with two few params, we actually get back a 'partially applied'
-- function. In most  other langs this would just be an error. That partially applied function
-- would just be an anony func that takes as many params as we left out. This way we can create
-- functions on the fly and pass them to other functions or seed them with data.

-- Here's a simple exaample.
multThree::Num a=>a->a->a->a
multThree x y z = x*y*z

-- so this multThree 3 5 9 is actually ((multThree 3) 5) 9. the first function created with 3
-- takes a number and will multiply it by 3. Once w give that 5 it creates another function that
-- will now take a param and multiply it by 15 ... 
-- NOTE that this type could also be written like multThree::Num a=>a->(a->(a->a)) o sea a
-- function that returns a function that returns a function that returns an a

-- we can now do stuff like this, using the partially applied functions to create more funcs
multTwoWithNine = multThree 9
multWithEighteen = multTwoWithNine 2

-- This is why creating functions that return 'Ordering' work
compareWithHundred :: (Num a,Ord a) => a -> Ordering -- so when I saw this before in actuality what
-- I was returning was a partially applied function? No, apparently Ordering is a type of constant
-- GT, LT, EQ, etc
compareWithHundred x = compare 100 x -- compare takes 2 args we gave it one constant 100 and 
-- returned a function that takes 1 more arg to compare to  100.

-- NOTE: CURRIED FUNCTIONS AND PARTIAL APPLCIATION ARE SUPER IMPORTANT TO UNDERSTANDING HASKELL

-- Partial functions apply to all functions, including 'infix' functions. Which make it super easy
-- to do a lot of basic things. 
divideByTen :: Floating a => a -> a
divideByTen = (/10) -- instead of 10 / x we simply use the (/) version to go before both args 
-- and give it one of the args 10. So whatever the next arg is will be x/10
-- in fact:
    -- 200/10
    -- (/) 200 10
    -- (/10) 200
    -- (200/) 10
    -- ARE ALL THE SAME THING

-- here's another example
isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z']) -- here I have to use `elem` the backticks. Otherwise
-- if I put elem ['A'..'Z'] it'll think that its the first arg and not the second. I could
-- make it work but having to use an arg then. Cuz NOTE that I have Char in the type but I
-- don't use a var for char in the definition at all. But if I don't use the backticks I 
-- would have to in order to tell haskell where to put the arg, and its not really partially
-- applied functions in that case then 
isUpperAlphanum' :: Char -> Bool
isUpperAlphanum' x = elem x ['A'..'Z']

-- NOTE: (-4) this means negative 4 in haskell,so if you want a partially applied function that
-- subracts 4, use (subtract 4) 


-- SOME HIGHER-ORDERISM IS IN ORDER
-- functions can also take functions and return functions. Here we have a function that applies
-- something twice. Its takes a function and returns the function to be applied on something else
applyTwice :: (a -> a) -> a -> a -- NOTE: the () are necessary when you are taking a function as
-- an argument. 
applyTwice f x = f(f x)

-- NOTE: Its good to know what's going on under the hood, but typically most folks will simply 
-- say that a function takes 2 or 3 or whatever parameters, even though we know its actually 
-- only ever taking 1 and returning a curried function.

-- another good example is implementing our own 'zipwith'
zipWith'::(a->b->c)->[a]->[b]->[c] -- this takes a function that takes two args and returns a value
-- and also  takes two additionals list and overall returns a list of c type.
zipWith' _ []_ = [] -- these are the base cases since this is a recursive list iteration func
zipWith' _ _ [] = [] -- first two pattern cases. empty lists return empty lists
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys -- recursie case 

{-
    As we can see here a single higher order function can be used in very versatile ways. 
    Imperative programming usually does this kind of thing with a bunch of for loops, and while
    loops, settimg something to a var, checking its state, etc. And then wrap it all in an 
    interface, like a function so it doesn't look so complex. Functional programming uses
    higher order functions to abstract away common patterns and KISS
-}

-- here's another example
flip'::(a->b->c)->(b->a->c) -- this looks like a function that takes a function that takes
-- an a and b returns c, and it returns a function that takes b and a. 
flip' f = g
    where g x y = f y x

-- and since this math than if g x y = f y x that means that f y x = g x y, so....
flip2 :: (a->b->c)->b->a->c
flip2 f y x = f x y -- more simple

-------------------------------------------------------
-- MAIN
-------------------------------------------------------
main = do
    print $ multTwoWithNine 2 3
    print $ multWithEighteen 10
    print $ divideByTen 200
    print $ isUpperAlphanum 'M'
    print $ isUpperAlphanum' 'M'
    print $ applyTwice (+3) 10
    print $ applyTwice (++ " Haha") "Hey"
    print $ applyTwice ("Haha " ++) "Hey"
    print $ applyTwice (multThree 2 2) 9
    print $ applyTwice (3:)[1]
    print $ zipWith' (+) [4,2,5,6][2,6,2,3]
    print $ flip' zip [1,2,3,4,5] "hello"
    print $ flip2 zip [1,2,3,4,5] "Kevin"
    print $ zipWith (flip2 div) [2,2..][10,8,6,4,2]
    
