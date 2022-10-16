incAll :: [Int] -> [Int]
incAll = map (\x -> x + 1)
-- incAll is = map (\x -> x + 1) is

addToAll :: Int -> [Int] -> [Int]
addToAll = \x -> map (\y -> x + y)
-- addToAll is = (\x -> map (\y -> x + y)) is
-- addToAll f is = (\x -> map (\y -> x + y)) is

keepOld :: [Int] -> [Int]
keepOld = todo

dropShort :: [String] -> [String]
dropShort = todo

todo = error "TODO"
