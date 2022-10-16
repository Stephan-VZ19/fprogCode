curry' :: ((a, b) -> c) -> (a -> b -> c)
curry' g x y = g (x, y)

uncurry' :: (a -> b -> c) -> ((a, b) -> c)
uncurry' g (x, y) = g x y