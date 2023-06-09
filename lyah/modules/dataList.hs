-- The Data.List module is all about lists. Some of these functions are already exported by Prelude
import Data.List


main = do
-- intersperse takes an element and a list and then puts that element in between each pair
-- of elements in the list
  print $ intersperse '.' "MONKEY"
  print $ intersperse 0 [1,2,3,4,5,6]
  
  -- intercalate takes a list and a list of lists and then inserts that list in between all those
  -- lists and then flattens the result
  print $ intercalate " " ["hey","there","Delilah"]
  print $ intercalate [0,0,0][[1,2,3],[4,5,6],[7,8,9]]
  
  -- transpose a list of lists. If you look at a list of lists as a 2d matrix, columns become rows and 
  -- vice verse
  print $ transpose [[1,2,3],[4,5,6],[7,8,9]]
  print $ transpose ["hey","there","Delilah"]
  
  -- concat flattens a list of lists into just a list of elements
  print $ concat ["foo","bar","car"]
  print $ concat [[3,4,5],[2,3,4],[2,1,1]]
  
  -- concatMap is the same as mapping a funtion and the concating the results
  print $ concatMap (replicate 4) [1..3]
  
  -- and takes a list of booleans and returns True if all values are true
  print $ and $ map (>4) [5,6,7,8]
  print $ and $ map (==4) [4,4,4,4,4,5]
  
  -- or is like and but only returns true if any of the boolean values are true
  print $ or $ map (==4) [2,3,4,5,6]
  
  -- any and all takes a pred and then checks if any or all of the elements satisfy. Its better
  -- to use these funcs rather than mapping  and the ndoing and/or
  print $ any (==4) [2,3,5,6,1,4]
  print $ all (>4) [6,9,10]
  print $ all (`elem` ['A'..'Z']) "HEYGUYSwhatsup"
  print $ any (`elem` ['A'..'Z']) "HEYGUYSwhatsup"
  
  -- iterate takes a function and a starting value and then applies the function to the starting
  -- value and then continues to apply the func to the result for an infinite list
  print $ take 10 $ iterate (*2) 1
  print $ take 3 $ iterate (++ "haha") "haha"
  
  
  -- splitAt takes a number and a list and the nsplits the list at that many elements
  print $ splitAt 3 "heyman"
  print $ splitAt 100 "heyman"
  print $ splitAt (-3) "heyman"
  print $ let (a,b) = splitAt 3 "foobar" in b++a

  -- takeWhile
