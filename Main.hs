{-# LANGUAGE DataKinds #-}

module Main where

import Servant
import Data.ByteString
import Data.ByteString.Lazy (toStrict)
import Data.Aeson
-- import Data.Aeson.Types
import Data.Attoparsec
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
    return $ toStrict $ getResponseBody resp


main :: IO ()
main = do 
    resp <- makeRequest
    print $ parse json resp

    run 8081 (myApp)

    where
        myApp = tempApp "25"
