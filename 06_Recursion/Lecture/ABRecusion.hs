-- Aufgabe 2

countDown :: Int -> [Int]
countDown 0 = [0]
countDown n = [n] ++ countDown (n-1)