-- 10.1 Seite 220

doubleAll :: [Int] -> [Int]
doubleAll a = map (\x -> 2 * x) a

doubleAll' :: [Int] -> [Int]
doubleAll' a
    | length == 0 = []
    | length >= 1 = [head a] ++ doubleAll (a-1)