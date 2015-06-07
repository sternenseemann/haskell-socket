{-# LANGUAGE OverloadedStrings, ScopedTypeVariables, TypeFamilies #-}
module Main where

import Data.Bits
import Data.Monoid
import Control.Monad
import Control.Exception
import System.Socket
import System.Socket.Family.INET
import System.Exit

main :: IO ()
main = do 
  t0001
  t0002

t0001 :: IO ()
t0001 = do
  ais <- getAddrInfo
          (Just "127.0.0.1")
          (Just "http")
          aiNUMERICHOST 
          `onException` p 0 :: IO [AddrInfo INET STREAM TCP]
  when (length ais /= 1) (e 1)
  let [ai] = ais
  when (addrCanonName ai /= Nothing) (e 2)
  let addr = addrAddress ai
  when (sinPort addr /= 80) (e 3)
  when (sinAddr addr /= inaddrLOOPBACK) (e 4)
  where
    p i = print ("t0001." ++ show i)
    e i = error ("t0001." ++ show i)

t0002 :: IO ()
t0002 = do
  let x = getAddrInfo
          Nothing
          Nothing
          mempty :: IO [AddrInfo INET STREAM TCP]
  eui <- tryJust (\ex@(AddrInfoException _)-> if ex == eaiNONAME then Just () else Nothing)
                 (x `onException` p 0)
  when (eui /= Left ()) (e 1)
  where
    p i = print ("t0002." ++ show i)
    e i = error ("t0002." ++ show i)