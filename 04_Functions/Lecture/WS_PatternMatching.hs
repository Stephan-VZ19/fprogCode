-- Aufgabe 1

switchFirstTwo :: [a] -> [a]
switchFirstTwo [] = []
switchFirstTwo [x] = [x]
switchFirstTwo (a:b:cs) = b:a:cs
switchFirstTwo [x, y, _] = [y, x, _]

-- Aufgabe 2

-- a)

type Vec = (Int, Int)

addVec :: Vec -> Vec -> Vec
addVec (x, y) (u, v) = (x+u, y+v)

--b)

addOpt :: Int -> Int -> Int
addOpt x 0 = x
addOpt 0 y = y
addOpt x y = x + y

addVecOpt :: Vec -> Vec -> Vec
addVecOpt (xa,ya) (xb,yb) = (addOpt xa ya, addOpt ya,yb)