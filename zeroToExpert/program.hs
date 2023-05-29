-- factorial
factorial :: Integer -> Integer
factorial 0 = 1 -- base case since we are doing recursion
factorial n = n * factorial (n-1)

double x = 2 * x

