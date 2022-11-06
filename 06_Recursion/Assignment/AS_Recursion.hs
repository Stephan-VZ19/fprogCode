-- Ubung: Rekursion

-- Aufgabe 1
-- a)

max' :: (Ord a) => a -> a -> a
max' x y
    | x >= y = x
    | otherwise = y

maxl :: (Ord a) => [a] -> a
maxl [] = error "empyt list"
maxl (x:y:[]) = max' x y
maxl (x:y:xs) = maxl ((max' x y):xs)