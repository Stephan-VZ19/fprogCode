main :: IO ()
main = do putStrLn "Welcome to Minicalc!"
          putStrLn "Please enter a number to be added:"
          num1 <- getLine
          let num11 = read num1 :: Int
          putStrLn "Please enter a second number to be added:"
          num2 <- getLine
          let num22 = read num2 :: Int
          let res = show (num11 + num22)
          let msg = "Sum = " ++ num1 ++ " + " ++ num2 ++ " = " ++ res
          putStrLn msg