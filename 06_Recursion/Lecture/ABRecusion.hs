-- Aufgabe 2

countDown :: Int -> [Int]
countDown n
    | n < 0     = n ++ []
    | otherwise = [n] ++ [countDown n-1]