{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Network.Discord
import System.Environment
import Data.Proxy
import Control.Monad.IO.Class

instance DiscordAuth IO where
    auth    = Bot <$> getEnv "BOT_AUTH"
    version = return "test-0.1"
    runIO   = id

data HelloWorld

instance EventMap HelloWorld (DiscordApp IO) where
    type Domain   HelloWorld = Init
    type Codomain HelloWorld = ()


    mapEvent _ _ = liftIO $ putStrLn "connected OK"

type HelloWorldApp = ReadyEvent :> HelloWorld

instance EventHandler HelloWorldApp IO

main :: IO ()
main = runBot (Proxy :: Proxy (IO HelloWorldApp))
