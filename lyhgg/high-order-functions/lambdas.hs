-- LAMBDAS
-- These are basically the anony funcs I'm used to. To make a lambda in Haskell we use the \, cuz
-- it kinda looks like the greet letter lambda...kinda. After the \ and parameters separated by
-- spaces comes a -> and then the function body. By convention they are surrounded by ()s otherwise
-- they extend all the way to the right and would bleed into the outer function they are being used
-- in or with. 

-- Let's see how we coulda used a \ instead of the where binding for our numLongChains function
chain :: Integral a => a -> [a]
chain 1 = [1]
chain n
  |even n = n:chain (div n 2)
  |odd n = n:chain (n*3+1)

numLongChains :: Int 
numLongChains = length (filter (\xs -> length xs > 15) (map chain [1..100]))
-- since lambdas are just expressions, we can pretty much pass them anywhere, just like we do
-- let/in and if/else. (\xs->length xs > 15) returns a function that tells us whether the length
-- of the list passed to it is greater than 15. 

-- NOTE that a lot of people use lambdas in places that they don't need to cuz they don't really 
-- understand currying functions or partially applied functions. Some would create a lamda for
-- something where they could just do (+3) 

-- As mentioned above we usually put lambdas in ()s unless we mean for them to expand all the way to
-- the right. For example, the following are the same
addThree :: Num a => a -> a -> a -> a
addThree x y z = x + y + z

addThree2 :: Num a => a -> a -> a -> a
addThree2 = \x -> \y -> \z -> x + y + z


-- ONLY FOLDS AND HORSES:






main = do
  -- lambdas can take any number of params.
  print $ zipWith (\a b -> (a * 30 + 3) / b)[5,4,3,2,1] [1,2,3,4,5]
  -- you can also pattern match, with the caveat that you can't define several patterns for one
  -- parameter like we do in named functions. If pattern matching fails in a lambda, it breaks at
  -- runtime. There's no fallthrough. 
  print $ map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]
  
  



