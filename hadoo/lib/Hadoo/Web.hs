{-# LANGUAGE OverloadedStrings #-}

module Hadoo.Web where

import Web.Scotty 
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Control.Monad.IO.Class (liftIO)
import System.Directory
import qualified Data.Text.Lazy as LT
import Control.Monad

import Hadoo.Factory
import Hadoo.Storage

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev

  get "/styles.css" styles
  get "/" indexAction
  get "/demo" demoPageAction
  get "/test" testPageAction
  get "/new" createItem
  post "/items" itemCreated
  get "/items/:state/:nr/edit" editItem
  post "/items/:state/:nr/" itemEdited
  post "/items/:state/:nr/move/:nextState" stateChanged
  post "/items/:state/:nr/delete" itemDeleted

styles :: ActionM ()
styles = do
    setHeader "Content-Type" "text/css"
    file "static/styles.css"

-- | Diese Funktion entfernt `\r` Control Characters aus den übertragenen Daten.
-- Sie müssen diese Funktion verwenden um Multiline Textinput ("content") aus einer 
-- Textarea auszulesen.
multiLineTextParam :: String -> ActionM String
multiLineTextParam paramName = fmap (filter (/='\r')) (param (LT.pack paramName))

htmlString :: String -> ActionM ()
htmlString = html . LT.pack

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

-- | Hauptseite
indexAction :: ActionM () 
indexAction = htmlString $ ("<head><link rel='stylesheet' href='styles.css'> </link></head>") ++
  createPage "Hadoo"
  ++ ea "a" [("href", "./new")] "Create new item"
  ++ ea "div" [("class", "container")]  -- container for all
    (firstLane
    ++ (secondLane
    ++ (ea "div" [("class", "lane")] ( -- third lane
      (ea "div" [("class", "title")] "Done [1]")
      ++ (ea "div" [("class", "item")] (  -- item
        (e "pre" "And this item is \"Done\"."))   -- textfield
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))] 
          (((ea "button" [("type", "submit")] "&lt;")
          ++ (ea "button" [("type", "submit")] "Edit")
          ++ (ea "button" [("type", "submit")] "Delete")
          ))))))
      ))

firstLane :: Html
firstLane = ea "div" [("class", "lane")] (   -- first lane
      (ea "div" [("class", "title")] "Todo [2]")  -- lane title
      ++ (ea "div" [("class", "item")] (  -- item
        (e "pre" "This item is in state \"Todo\"."))
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))] 
          itemButtons
        )
      )
      ++ (ea "div" [("class", "item")] (  -- item
        (e "pre" "This item also."))
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))] 
          itemButtons
        )
      )    
    )

secondLane :: Html
secondLane = ea "div" [("class", "lane")] ( -- second lane
      (ea "div" [("class", "title")] "Started [1]")
      ++ (ea "div" [("class", "item")] (  -- item
        (e "pre" "This is already \"Started\"."))   -- textfield
        ++ (ea "form" [("method", "post"), ("action", "/items/Todo/1/move/Started"), (("class", "inline"))]
          ((ea "button" [("type", "submit")] "&lt;") 
          ++ itemButtons)
        )
      )
    )

-- | get /new Funktion
createItem :: ActionM ()
createItem = htmlString $ createPage "Hadoo"
  ++ e "label" "State:"
  ++ dropDownMenu
  ++ textArea
  ++ saveButton

-- | post /items Function
itemCreated :: ActionM ()
itemCreated = do
  text <- multiLineTextParam "content"
  st <- param "dropdown" :: ActionM String
  liftIO (writeFile ("data/" ++ st ++ "/" ++ calcNumber ++ ".txt") text)
  redirect "/"

-- | get /item/:state
getdata :: ActionM ()
getdata = htmlString $ e "h1" "parse folder"

editItem :: ActionM ()
editItem = htmlString $ e "h1" "create page"

itemEdited :: ActionM ()
itemEdited = htmlString $ e "h1" "create page"

stateChanged :: ActionM ()
stateChanged = htmlString $ e "h1" "create page"

itemDeleted :: ActionM ()
itemDeleted = htmlString $ e "h1" "create page"