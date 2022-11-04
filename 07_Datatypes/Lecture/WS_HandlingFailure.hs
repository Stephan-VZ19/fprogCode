-- a)

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x

-- b)

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail [_] = Nothing
safeTail (x:xs) = Just xs

-- c)

safeMax :: (Ord a) => [a] -> Maybe a
safeMax [] = Nothing
safeMax [a] = Just a
safeMax [a, b]
    | a > b = Just a
    | otherwise = Just b
safeMax (x:y:xs)
    | x > y = Just safeMax (x:xs)
    | otherwise = Just safeMax (y:xs)