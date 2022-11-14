main :: IO ()
main = do putStrLn "Please enter a number to be added:"
          number <- getLine
          putStrLn "Please enter a second number to be added:"
          num2 <- getLine
          let msg = "Sum = "
          putStrLn msg
          putStrLn (number + num2)