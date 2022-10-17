-- Aufgabe 2

countDown :: Int -> [Int]
countDown n
    | n == 0 = [0]
    | n > 0 = [n] ++ countDown (n-1)


-- oder
-- countDown 0 = [0]
-- countDown n = [n] ++ countDown (n-1)