incAll :: [Int] -> [Int]
incAll = map (\x -> x + 1)
-- incAll is = map (\x -> x + 1) is

addToAll :: Int -> [Int] -> [Int]
addToAll = \x -> map (\y -> x + y)
-- addToAll is = (\x -> map (\y -> x + y)) is
-- addToAll f is = (\x -> map (\y -> x + y)) is

keepOld :: [Int] -> [Int]
keepOld is = filter (\i -> i >= 90) is
-- don't know why it doesn't work

dropShort :: [String] -> [String]
dropShort ss = filter (\s -> length s /= 1) ss

-- todo = error "TODO"
