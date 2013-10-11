{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment (getArgs)
import Data.ByteString.Char8 (readFile)

main :: IO ()
main = do
  (grammarFileName:_) <- getArgs
  file                <- readFile $ grammarFileName
