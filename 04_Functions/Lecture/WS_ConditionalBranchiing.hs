-- a)

max1 :: Int -> Int -> Int
max1 a b | a < b = b
         | a > b = a
         | otherwise = a

-- b)

max2 :: Int -> Int -> Int
max2 a b = if a < b
    then a
    else b

-- c)

max3 :: Int -> Int -> Int
max3 a b = case a < b of
    True -> b
    False -> a

-- d)

max4 :: Int -> Int -> Int
max4 a b = a < b -> a
max4 a b = a > b -> b
max4 _ _ = a
