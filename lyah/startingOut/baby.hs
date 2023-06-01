doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                        then x
                        else x*2 --in haskell the else is mandatory as every function must return val

-- we can also do it like this
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1 -- in one line

-- NOTE: the ' at the end of the funtion name. That doesn't have any special meaning in Haskell
-- It's a valid char to sue in a function. By convention we use that to either denote a strict
-- version of a function (one that isn't lazy) or a slightly modified version of a function
-- or var. Wow, so rather than me adding the 2 they do this. Interesting. Very thought-through

-- that also means we can make functions like this:
conanO'Brien = "It's a-me, Conan O'Brien!"

-- 2 things to NOTE here. 
-- First, we can't capitalize functions. Thus conan and not Conan, we'll get to that later
-- Second This function doesn't take any parameters. Its still a function, but without params
-- we normally call it a definition. In reality its so true. Functions are all about equality
-- or stating that someting IS something else. Its math. So even definitions are actually
-- functions with no params and when you run them they return whatever was assigned to them.
-- Mindblowing!

-- We can't change what names and functions mean once we've defined them.


