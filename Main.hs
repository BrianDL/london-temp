{-# LANGUAGE DataKinds #-}

module Main where

import Servant
import Network.Wai.Handler.Warp

type RootEndpoint = Get '[PlainText] MyMSG
type MyMSG = String


defaultMsg :: MyMSG
defaultMsg = "let's now fetch London's temp!"

server :: Server RootEndpoint
server = return defaultMsg

msgAPI :: Proxy RootEndpoint
msgAPI = Proxy

myApp :: Application
myApp = serve msgAPI server

main :: IO ()
main = do 
    putStrLn "Hello, Haskell!"
    run 8081 myApp
