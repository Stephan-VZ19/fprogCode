{-# LANGUAGE OverloadedStrings #-}

module Hadoo.Web where

import Web.Scotty 
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Control.Monad.IO.Class (liftIO)
import qualified Data.Text.Lazy as LT
import Data.List (intersperse)


main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev

  get "/styles.css" styles 
  get "/" indexAction
  get "/demo" demoPageAction
  get "/test" testPageAction

styles :: ActionM ()
styles = do
    setHeader "Content-Type" "text/css"
    file "static/styles.css"

-- | Diese Funktion entfernt `\r` Control Characters aus den übertragenen Daten.
-- Sie müssen diese Funktion verwenden um Multiline Textinput ("content") aus einer 
-- Textarea auszulesen.
multiLineTextParam :: String -> ActionM String
multiLineTextParam paramName = fmap (filter (/='\r')) (param (LT.pack paramName)) 

demoPageAction :: ActionM ()
demoPageAction = do
    demoPage <- liftIO (readFile "static/lanes_example.html")
    htmlString demoPage

testPageAction :: ActionM ()
testPageAction = htmlString $ 
  e "h1" "Hadoo"  -- title
  ++ ea "div" [("class", "container")]  -- container for all
    (ea "div" [("class", "lane")] (   -- first lane
      (ea "div" [("class", "title")] "Todo")
      ++ (ea "div" [("class", "item")] (
        (e "pre" "Todo1: \n Es gibt noch viel zu tun"))
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))] 
          (ea "button" [("type", "submit")] "&gt;")
        )
      )     
    )
          
  )
  

indexAction :: ActionM () 
indexAction = htmlString $ e "h1" "Hadoo Neu" 

htmlString :: String -> ActionM ()
htmlString = html . LT.pack

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
