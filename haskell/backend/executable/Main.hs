{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics

import qualified Data.Text.Lazy as L

main :: IO ()
main = do -- IO Monad
  putStrLn "Startin Server at 4711 ..."
  scotty 4711 $ do -- ScottyM Monad
    get "/hello" $ do  -- ActionM
      text "Hello World!"
    get "/hello/:name" $ do
      name <- param "name"
      text $ L.pack ("Hello " ++ name ++ "!")
    get "/address" $ do
       json a4


a4 :: Address
a4 = Address "Byvej 4" "Roskilde"

data Address = Address
  { street :: String
  , city :: String
  } deriving (Show, Generic)

instance ToJSON Address


-- >>=

-- --> IO ()
-- getLine -> IO String
-- (<-) :: IO String -> IO ()
-- putStrLn :: String -> IO ()

-- text "Hello to you " ++ name ++ "!"
-- (text "Hello to you ") ++ name ++ "!"
-- ((text "Hello to you ") ++ name) ++ "!"

-- text ("Hello to you " ++ name ++ "!")
-- text <| "Hello to you " ++ name ++ "!"
-- "Hello to you " ++ name ++ "!" |> text
