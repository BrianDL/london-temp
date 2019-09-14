{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-} 

module Main where

import Servant
import Data.ByteString.Lazy (ByteString)
import Data.Aeson
import Data.Aeson.Lens
import Data.Aeson.Types
import Control.Lens
import Network.Wai.Handler.Warp
import Network.HTTP.Simple (httpLBS, httpJSON, parseRequest
    , getResponseStatusCode, getResponseBody)


type RootEndpoint = Get '[PlainText] MyMSG
type MyMSG = String


tempMsg :: String -> MyMSG
tempMsg degrees = "Hello from London, it is " ++ degrees ++"C\n"

tempServer :: String -> Server RootEndpoint
tempServer = return . tempMsg

msgAPI :: Proxy RootEndpoint
msgAPI = Proxy

tempApp :: String -> Application
tempApp = (serve msgAPI) . tempServer

myEndpoint :: String
myEndpoint = "https://api.openweathermap.org/data/2.5/forecast?id=2643743&units=metric&APPID=82cf415ef1f8714d6709871fc4147d0a"

makeRequest :: IO ByteString
makeRequest = do 
    req <- parseRequest myEndpoint
    resp <- httpLBS req
    return $ getResponseBody resp

getTemp :: Maybe Value -> String
getTemp (Nothing) = "0.0"
getTemp (Just val) = 
    let Just obj = val ^? key "list" . nth 39
        Just mainObj = obj ^? key "main"
        Just tempObj = mainObj ^? key "temp"
    in drop 7 $ show tempObj


main :: IO ()
main = do 
    resp <- makeRequest
    let temp = getTemp $ (decode resp :: Maybe Value)

    run 8081 (tempApp temp)
