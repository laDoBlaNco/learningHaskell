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

-- NOTE: don't use ranges with floats. The outputs aren't always very accurate because they aren't
-- that precise, as is with floating precision numbers

-- There's also ininite ranges, and rather than run forever HS only gives you what you ask for
d = take 24 [13,26..] -- taking first 24 multiples of 13

-- There are also some funcs that we can use that create infinite lists or patterns
e = take 10 (cycle [1,2,3]) -- this cycles through 1 2 3 until we have 10 numbers
f = take 12 (cycle "LOL ") -- we can do it with strings as well.

-- repeat creates an infinite list of 1 item
g = take 10 (repeat 5)

-- and even easier than repeat is 'replicate' which in my opinion is a little backwards, but works
h = replicate 3 10 -- [10,10,10] o sea, replicate 3 times the number 10


-- LIST COMPREHENSIONS 
-- The first time I ran into list comprehensions was in Python, and I've been in love with them
-- since. HS uses the math model of set comprehension for its list comprehension. And again since
-- lists are such an integral part of Haskell, there are some pretty amazing things they can do
-- it allows me to see programming in a new functional manner.
-- In general its [output | binding, filters] so the output x*2 then | then where the x comes from
-- x <- [1..10] and then if there are any conditions/filters after the , x*2>=12. So I would say it
-- like: Give me x times 2 for every x of range 1 to 10 if x times 2 is great than or equal to 12.

i = [x*2 | x <- [1..10], x*2 >= 12]

j = [x|x<-[50..100],x `mod` 7 == 3]

-- Now let's try something a little different. Creating a function off of a list comp
boomBang xs = [if x < 10 then "Boom!" else "Bang!"|x <- xs, odd x] -- Here both the output and
-- the filter are conditionals, but the filter is a strict True/False situation and the output
-- is more just something we are doing with each x. So this example solidifies that we are binding 
-- the range to the x var and then using the filter after the comma to its right to determine if that
-- x passes over the | to the output function.

-- we can also add various predicates (filters) if we want to. Each element that passes the barrier |
-- must pass all the filters
k = [x|x<-[10..20],x/=13,x/=15,x/=19]

-- Not only that, we can have multiple sourcing/binding as well so that our output function can work
-- with more than one var.
l = [x*y|x<-[2,5,10],y<-[8,10,11]] -- this just did what in other languages would have been a 
-- nested for loop in a for loop
-- And of course we can use multiple sources and filters together
m = [x*y|x<-[2,5,10],y<-[8,10,11],x*y>50]

-- let's play with this
nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]
n = [adjective++" "++noun|adjective <- adjectives,noun<-nouns]

-- let's write our own version of 'length' using these comps
length' xs = sum[1|_<-xs] -- NOTE first time using _ which I'm assuming is our ignoration char :)
-- rather than caring about what's in xs, we are simply returning 1 for every iteration. Then summing
-- up all the ones.

-- remember that strings are just lists, so let's comphrehencion them...
removeNonUppercase st = [c|c<-st, elem c ['A'..'Z']]

-- for nested lists we simply use nested comprehensions
xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]
o = [[x|x<-xs,even x]|xs <- xxs] -- we nest comprehension by making the output function a list comp
-- itself. So above the outer comp just says pass over the | each inner list. then the inner comp
-- takes that and for each gets x sourced from each list, checks if its even and then passes it over
-- the wall | to be returned. and since we always return a list, in this case we return the same 
-- nested list structure after the mutations.



