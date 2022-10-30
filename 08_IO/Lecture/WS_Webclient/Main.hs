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
    putStrLn "Load the current weather from https://wttr.in"
