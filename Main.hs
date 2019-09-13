{-# LANGUAGE DataKinds #-}

module Main where

import Servant
import Network.Wai.Handler.Warp
import Network.HTTP.Simple (httpLBS, getResponseStatusCode, parseRequest)


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
myEndpoint = "https://api.openweathermap.org/data/2.5/forecast?id=2643743&APPID=82cf415ef1f8714d6709871fc4147d0a"

main :: IO ()
main = do 
    putStrLn "Hello, Haskell!"
    req <- parseRequest myEndpoint
    resp <- httpLBS req

    putStrLn $ show (getResponseStatusCode resp)

    run 8081 (myApp resp)

    where
        myApp = tempApp . show . getResponseStatusCode
