module Main where

import System.Environment
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import qualified Data.ByteString.Lazy.Char8 as L8

-- cabal repl
-- :main Arg1
-- :set args Arg1
-- cabal run webclient Arg1
main :: IO ()
main = do
    manager <- newManager ...
    let manager2 = read manager :: Manager
    let urlA = "https://wttr.in/"
    let urlB = "?format=3"
    putStrLn "Please enter the location:"
    location <- getLine
    let loc = read location :: String
    let url = urlA ++ loc ++ urlB
    request <- parseRequest url





    putStrLn "Load the current weather from https://wttr.in"
