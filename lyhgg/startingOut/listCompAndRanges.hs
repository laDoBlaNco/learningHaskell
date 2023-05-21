-- Ranges are pretry intuitive with Haskell.
x = [1..20]

-- They work with any list that can be enumerated, such as a list of chars
y = ['a'..'z']
z = ['k'..'z']

-- you can also specify steps by starting the pattern for hs to follow with the first step
a = [2,4..20] -- [2,4,6,8,10....20]
b = [3,6..20] -- [3,6,9,12,15,18]

-- to count down you have to use this stepping, rather than just [20..1]
c = [20,19..1]

-- NOTE: don't use ranges with floats. The results aren't always very accurate because they aren't
-- that precise, as is with floating precision numbers

-- There's also ininite ranges, and rather than run forever HS only gives you what you ask for
d = take 24 [13,26..] -- taking first 24 multiples of 13

-- There are also some funcs that we can use that create infinite lists or patterns
e = take 10 (cycle [1,2,3]) -- this cycles through 1 2 3 until we have 10 numbers
f = take 12 (cycle "LOL ") -- we can do it with strings as well.

-- repeat creates an infinite list of 1 item
g = take 10 (repeat )

-- and even easier than repeat is 'replicate' which in my opinion is a little backwards, but works
h = replicate 3 10 -- [10,10,10] o sea, replicate 3 times the number 10


-- LIST COMPREHENSIONS 
-- The first time I ran into list comprehensions was in Python, and I've been in love with them
-- since. HS uses the math model of set comprehension for its list comprehension. And again since
-- lists are such an integral part of Haskell 


