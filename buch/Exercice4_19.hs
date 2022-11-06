recursivMult :: Int -> Int -> Int
recursivMult 0 0 = 0
recursivMult 0 b = 0
recursivMult a 0 = 0
recursivMult a b = b + recursivMult (a-1) b