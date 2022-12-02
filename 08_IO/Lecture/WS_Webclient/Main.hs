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
    manager <- newManager tlsManagerSettings
    [location] <- getArgs
    let url = buildURL location
    request <- parseRequest url
    response <- httpLbs request manager
    let body = responseBody response
    L8.putStrLn body

buildURL :: String -> String
buildURL location = "https://wttr.in/~" ++ location ++ "?format=3"
