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

-- | Link styles.css
linkCSS :: String
linkCSS = "<head><link rel='stylesheet' href='styles.css'> </link></head>"

-- | Erzeugt die Index-Startseite
renderStaticIndex :: String
renderStaticIndex = linkCSS ++
  e "h1" "Hadoo"  -- title
  ++ ea "div" [("class", "container")]  -- container for all
    (ea "div" [("class", "lane")] (   -- first lane
      (ea "div" [("class", "title")] "Todo")  -- lane title
      ++ (ea "div" [("class", "item")] (  -- item
        (e "pre" "Todo1: \n Es gibt noch viel zu tun"))   -- textfield
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))] 
          (ea "button" [("type", "submit")] "&gt;")
        )
      )     
    )
    ++ (ea "div" [("class", "lane")] 
      (ea "div" [("class", "title")] "Started")  -- lane title
      ++ (ea "div" [("class", "item")] (  -- item
        (e "pre" "Todo1: \n Es gibt noch viel zu tun"))   -- textfield
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))] 
          (ea "button" [("type", "submit")] "&gt;")
        )
      )
    )      
  )

-- | Erzeugt die vorhanden Items pro lane
renderItems :: String -> String
renderItems "Todo" = "..."
renderItems "Started" = "..."
renderItems "Done" = "..."
