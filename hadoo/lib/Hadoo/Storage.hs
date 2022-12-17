{-# LANGUAGE OverloadedStrings #-}

module Hadoo.Storage where



-- | Berechnet die passende Nummer
calcNumber :: String
calcNumber = "002"

-- | Entfernt die Fileendung .txt
dropEnding :: String -> String
dropEnding file = take 3 file

