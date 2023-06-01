-- Tuples have similiarities to lists but there are some differences
-- Tuples are used when you know exactly how many values you want to combine and its type
-- depends on how many components it has and the types of those components. 
    -- NOTE: for example, a tuple of size 2 is called a pair and thats its own type. So you couldn't
    -- have a list of tuples with 2 and 3 and 4 numbers as those would be different types.
    -- you get the error: Couldn't match expected type: (a,b) with actual type (a0,b0,c0)...
    -- which is sayint that we tried to use a pair and a triple in the same list.
    -- NOTE: Also you couldn't mix [(1,2),("one",2)] because this is a pair of numbers and the other
    -- is a pair of (string,number)...

-- Another differnce is that they are not homogenous, o sea they can contain a combination of
-- several types.

-- Tuples are used in Haskell for data representation as well. such as a triple
a =  ("Christopher","Walken",55) -- name and age
-- Tuples can also contain lists.

-- Use tuples when you know in advance how many components a piece of data should have. They are
-- much more rigid cuz each different size of tuple is its own type, so you can't write a function
-- that just appends something to a tuple, cuz that would change its type. You would need a function
-- for appending to a pair, a different one to append dto a triple, another for a 4-tuple, etc

-- Though you can have [6], you can't have (6). There is no such thing as a singleton tuple in hs
-- You also can't compare two tuples of different sizes like you can lists. 

-- SOME FUNCTIONS THAT WORK WITH TUPLE PAIRS
b = fst (8,11)
c = fst ("wow",False)
d = snd (8,11)
e = snd ("wow",False)
-- The above only work on the pairs type. They won't work on triples, 4-tuples, 5-tuples, etc. We
-- can do that with something else we'll see later.

-- We can also create pairs (a list of pairs) with 'zip'
f = zip [1,2,3,4,5][5,5,5,5,5,5] --- [(1,5),(2,5)...] NOTE that even though we have 6 in the 2nd list
-- we still on get 5 pairs created.
g = zip [5,5,5,5,5,5][1,2,3,4,5] -- same here. The extra from the first list is ignored.

h = zip [1..5]["one","two","three","four","five"]
i = zip [10..]["one","two","three","four","five"] -- here again is proof zip stops at the length of
-- the shorter of the two lists. infinite list vs 5
j = zip [5,3,2,6,2,7,2,5,4,6,6]["im","a","turtle"]
k = zip [1..]["apple","orange","cherry","mango"]

-- a sample of the types of problems made easy with haskell
-- Which right triangle that has integers for all sides and all sides equal to or smaller than 10
-- has a perimeter of 24? :-O 
-- First we generate all the triangles with sides equal to or smaller than 10
triangles = [(a,b,c)|c <-[1..10],b <-[1..10],a <-[1..10]] -- again this work need to be a triple 
-- nested for loop in a c language. this is powerful and EASY to grasp.

-- next we add a condition that they be right triangles
rightTriangles = [(a,b,c)|c<-[1..10],b<-[1..c],a<-[1..b],a^2+b^2==c^2]

-- now we just add another filter, that the perimeter must be 24
rightTriangles' = [(a,b,c)|c<-[1..10],b<-[1..c],a<-[1..b],a^2+b^2==c^2,a+b+c==24]
-- THAT WAS MAGICAL and way easier than Python. We just got a starting point and added the right
-- filters. All in the same list comp

-- NOTE: This is a common pattern in funtional programming, so I'm taking note. You take a starting
-- set of solutions and then you apply transformations to those solutions and filter them until you 
-- get the right ones. 


