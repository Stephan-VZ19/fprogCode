{-# LANGUAGE OverloadedStrings #-}

module Hadoo.Factory where

import Data.List (intersperse)

-- | Type Alias für Html Strings
type Html = String

-- | Erzeugt ein Element ohne Attribute
e :: String -> Html -> Html
e tag kids = ea tag [] kids

-- | Erzeugt ein Element mit Attributen
ea :: String -> [(String, String)] -> Html -> Html
ea tag attrs kids = concat $ ["<", tag] ++ attrsHtml attrs ++ [">", kids, "</", tag, ">"]
  where attrsHtml [] = []
        attrsHtml as = " " : intersperse " " (map attrHtml as)
        attrHtml (key, value) = key ++ "='" ++ value ++ "'"