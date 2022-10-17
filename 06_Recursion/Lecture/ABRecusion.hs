-- Aufgabe 2

countDown :: Int -> [Int]
countDown n
    | n < 0     = []
    | otherwise = [] ++ [countDown n-1]