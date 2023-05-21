-- AN INTRO TO LISTS
-- Here we talk about lists, strings (which are lists) and list comprehesions

lostNumbers = [4,8,15,16,23,42] -- for some reason it won't let me use let in the script
-- but I can use it in the repl. Strange

-- 'a' -- chars are denoted with ''
-- "hello" -- strings are just syntatic sugar for a list of chars
-- ['h','e','l','l','o']

-- I had to comment out the above cuz you can't have values just floating around and not being used
-- in or with some function (or definition). This is Haskell not JS :)

--NOTE: This is another mindblower. Much like lisp, lists are a major part of haskell. So we 'cons'
--onto the front of lists. This backwards from traditional langs. Here, to add something to the end
-- of a lists, haskel has to run though the entire list on the left side of ++. But to put it on the
-- front we just use the cons operator (:) which is instant. o(n) vs O(1). To add someting to
-- the end of a list in lisp we would also have to travel through the entire thing as its a linked
-- list.

-- NOTE that ++ takes two lists, even if the list has only 1 element, they both must have []
-- while : takes 1 element on the left and a list on the right.

-- More lispy stuff. [1,2,3] is just syntatic sugar for 1:2:3:[] just like
-- (cons 1 (cons 2 (cons 3 ()))). so in turn 3:[] should give us [3]

-- since lists are so key throughout haskell and much different than other langs, you can imagine
-- that getting by index would also be different. We use !!
-- "kevin"!!3 (indexes start at 0

-- lists can be compared if the stuff they contain can be compared.
-- They are compared in lexigraphical order when used with > < >=, etc. Meaning the heads are compared
-- first and then it runs down the list.

-- just like lisp you have much functions that work with lists
-- head, tail, last, init, etc.

-- and just like lisp, head and tail is the first and rest ;-O. That opens us up to all kinds of 
-- cool things just like in sicp, recursion, etc

-- last and init are the opposite of head and tail. meaning last is the last one and init is
-- everything before that. 

-- getting things from empty lists are runtime errors so its always good to check before with
-- things like 'length'

-- we have 'reverse' which is cool. 

-- Also 'take' with takes 2 args, the nubmer of items to take and the list. Taking more than the
-- list has, doesn't give us an error, we just get back the lists. Taking 0 gives us []

-- 'drop' is the opposite of take. This drops a certain amount of elements and gives us what's 
-- left.

-- Minimum and maximum work on lists as expected, returning the largest and smallest elements if 
-- the list is something that can be sorted.

-- sum does what you would think, but we also have product as well. 

-- Finally for this round, we have 'elem', which takes a thing and a list of things and tells us
-- if our thing is in the list of things. By convention its called as an `elem` function just
-- cuz its easier to read, but doesn't hve to be

-- Those were few of the basics. We'll take a look at more later. 


