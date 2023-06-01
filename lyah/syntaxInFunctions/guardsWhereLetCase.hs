--ghc 8.0.2
    
-- GUARDS
-- guards are a way of testing if some property value is true or false
-- to me it looks like its the Haskell version of case analysis
bmiTell::(RealFloat a)=>a->String
bmiTell bmi -- NOTE: there is no '=' here. Many newbies get errors for that as it kinda makes sense that there would be.
    |bmi<=18.5 = "Your're underweight, you emo, you!"
    |bmi<=25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    |bmi<=30.0 = "Your're fat! Lose some weight, fatty!"
    |otherwise = "You're a whale, congratulations!"
-- as we see guards are the | followed by the function name and its args. So its
-- basically a bool statement, just like a case structure. If its True its run and
-- if its false then it drops to the next guard.
-- Again this is very much like a big if/else tree or a case statement in other langs
-- but its much more readable
-- The last guard is 'otherwise' with is just a catch-all guard and a synonym for True

-- here's a different version showing some more complicated functions on guard
bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
    |weight/height^2 <=18.5 = "Your're underweight, you emo, you!"
    |weight/height^2<=25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    |weight/height^2<=30.0 = "Your're fat! Lose some weight, fatty!"
    |otherwise = "You're a whale, congratulations!"

-- Here's another simple example using the max function. Remembe to use ' when we create our own versions
max'::(Ord a)=>a->a->a
max' a b | a>b=a | otherwise=b
-- guards can also be written inline, but you lose readability.
-- Here's another example:
myCompare :: (Ord a) => a -> a -> Ordering -- haven't seen this before I don't think???
-- we can also define functions using backticks, same as we can use them
a `myCompare` b
    | a > b = GT -- These are types? or orderings?
    | a==b = EQ
    | otherwise = LT
    
-- WHERE!?
-- this is used to help make our code dryer. Instead of repeating ourselves, we can calculate the bmi
-- in the function, bind it to something and then use it. I would say its simply a local assignment
-- heres bmi again
bmiTell2 :: (RealFloat a) => a -> a -> String
bmiTell2 weight height
    |bmi<=18.5 = "Your're underweight, you emo, you!"
    |bmi<=25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    |bmi<=30.0 = "Your're fat! Lose some weight, fatty!"
    |otherwise = "You're a whale, congratulations!"
    where bmi = weight/height^2 -- just adding it on the end after the last guard.

-- you can even put multiple assignments after where
bmiTell3 :: (RealFloat a) => a -> a -> String
bmiTell3 weight height
    |bmi<=skinny = "Your're underweight, you emo, you!"
    |bmi<=normal = "You're supposedly normal. Pffft, I bet you're ugly!"
    |bmi<=fat = "Your're fat! Lose some weight, fatty!"
    |otherwise = "You're a whale, congratulations!"
    where bmi = weight/height^2 -- just adding it on the end after the last guard in the "where section"
          -- skinny = 18.5
          -- normal = 25.0
          -- fat = 30.0
          -- they are only visible to this function. 
          -- its also good to NOTE that lining things up in haskell is how you declare blocks. So if we don't line them up
          -- ghc will complain.
          -- We can also use pattern matching instead of several lines like above
          (skinny,normal,fat) = (18.5,25.0,30.0)
          
-- Here's another contrived example, but using the 'where section' in a function without guards. So its not strictly for guard structure.
initials::String->String->String
initials firstname lastname = [f]++". "++[l]++"."
    where (f:_)=firstname
          (l:_)=lastname

-- we can also define functions in where blocks just like constants. So here we create locally scoped functions
calcBmis::(RealFloat a)=>[(a,a)]->[a]
calcBmis xs=[bmi w h|(w,h)<-xs]
    where bmi weight height = weight/height^2 -- this is starting to feel like sql to me :D
-- Its also a common idiom to create helper functions in the where bindings section of a function and even have
-- helper functions for those helper functions as well, with its own where clause.

-- let bindings are super similar to where bindings, only that let bindings are more local. They don't span over guards. 
-- and yes they work with pattern matching as well, like everything else
cylinder::(RealFloat a)=>a->a->a
cylinder r h =
    let sideArea=2*pi*r*h
        topArea=pi*r^2
    in sideArea + 2 * topArea
-- so here the names bound in let are accessible only in the expression after 'in'. Also note the names lining up in the block
-- format. We could've done this as well in a where section, so whats the difference
    -- First, the order of the binding is reversed, with where you have the expression first and the binding later
    -- And for let..in you have the binding first and the expressions later.
    -- Second, let bindings are expressions themselves, an where bindings are just syntactic constructs. So just like an if/else statement
    -- as an expression you can cram it in almost anywhere. 

-- Using let/in expressions in list comps instead of the where bindings
calcBmis2::(RealFloat a)=>[(a,a)]->[a]
calcBmis2 xs = [bmi|(w,h)<-xs,let bmi=w/h^2] -- we use the let/in just like we would a filter/predicate
-- Let's combine let/in with a pred filter
calcBmis3::(RealFloat a)=>[(a,a)]->[a]
calcBmis3 xs = [bmi|(w,h)<-xs,let bmi=w/h^2,bmi>=25.0]

-- I noted that 'guards' is haskells case expression, but apprently we also have actual case expressions. In fact
-- that's what we use when we've lined up different 'cases' for multi-dispatched functions, or function overloading.
-- running expressions of a case depending on the matched pattern. So the below are both the same
-- one is just syntactic sugar for the other.
head2::[a]->a
head2[]=error "No head for empty lists!"
head2(x:_)=x

head3::[a]->a
head3 xs=case xs of [] -> error "No head for empty lists!"
                    (x:_)->x
-- very similar go guards as its plugged right onto the function, but this does have the '=' before it and guards don't
-- 

-- One NOTE is that pattern matching on function args can only be done in function definitions, while case expressions can 
-- just like let/in and if/else be used almost anywhere.
describeList::[a]->String
describeList xs = "The list is "++case xs of []->"empty."
                                             [x]->"a singleton list."
                                             xs->"a longer list."

-- a similar way using there where binding and pattern matching
describeList2::[a]->String
describeList2 xs = "The list is "++what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."

-- Tested and worked! main doesn't have to be at the top which is more functional for me. Its just like Go and Odin, etc    
main = do
    print $ "Hello Haskellers!"
    print $ bmiTell 30
    print $ bmiTell' 240 1.85
    print $ max' 66 69
    print $ 3 `myCompare` 2
    print $ myCompare 3 2 -- this makes more sense in my head
    print $ bmiTell2 108 1.85
    print $ bmiTell3 108 1.85
    print $ initials "Kevin" "Whiteside"
    print $ calcBmis [(100,1.85),(108,1.85),(240,1.85)]
    print $ cylinder 5 10
    -- using if/else and let/in expressions almost anywhere
    print $ [if 5>3 then "Woo" else "Boo",if 'a'>'b' then "Foo" else "Bar"]
        -- yeap, this is if/else to get results for a list :D
    print $ 4*(if 10>5 then 10 else 0) + 2
    print $ 4*(let a=9 in a+1)+2
        -- got the point! Can't do that with a where binding 
    -- Now what about introducing functions into local scopes, like in a nested tuple in a list literal :O
    print $ [let square x=x*x in (square 5,square 3,square 2)]
    -- if we can't line up what would normally be in blocks, we can use ';'
    print $ (let a=100;b=200;c=300 in a*b*c,let foo="Hey ";bar="there!" in foo++bar)
    -- and of course we can use pattern matching for quickly dismantiling tuples for example
    print $ (let (a,b,c)=(1,2,3) in a+b+c)*100
    -- we an also put them in list comps, so more compact and instead of the where binding. calcBmis2 above
    print $ calcBmis2 [(100,1.85),(108,1.85),(240,1.85)]
    print $ calcBmis3 [(100,1.85),(80,1.85),(240,1.85)]

    -- With let bindings, we can omit the 'in' and the bindings will be visible in the entire scope, but with 'in'
    -- its only visible in those expressions its being used 'in'
    -- That's the reason in ghci you can use 'let' to bind values and they are visible throughout the interative session.
    -- but we could use 'in' in the interactive session as well to keep them contained in specific expressions.
    
    print $ head2 [1,2,3,4,5]
    print $ head3 [1,2,3,4,5]
    
    print $ describeList [1,2,3,4,5]
    print $ describeList2 [69]
    print $ describeList []
    -- I'M LOVING ME SOME HASKELL
    
