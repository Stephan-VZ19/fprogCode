{-# LANGUAGE OverloadedStrings #-}

module Hadoo.Web where

import Web.Scotty 
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Control.Monad.IO.Class (liftIO)
import qualified Data.Text.Lazy as LT

import Hadoo.Factory

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev

  get "/styles.css" styles 
  get "/" indexAction
  get "/demo" demoPageAction
  get "/test" testPageAction
  post "/009/create" createItem

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
testPageAction = htmlString $ ("<head><link rel='stylesheet' href='styles.css'> </link></head>") ++
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
    

deleteItem :: ActionM ()
deleteItem = htmlString $ e "h1" "delete page"

createItem :: ActionM ()
createItem = htmlString $ e "h1" "create page"


indexAction :: ActionM () 
indexAction = htmlString $ e "h1" "Hadoo, to be implemented" 

htmlString :: String -> ActionM ()
htmlString = html . LT.pack


