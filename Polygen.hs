{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Attoparsec.ByteString
import qualified Data.ByteString.Char8 as BS (readFile)
import           Polygen.Parser (parseRule)
import           System.Environment (getArgs)

main :: IO ()
main = do
  (grammarFileName:_) <- getArgs
  file                <- BS.readFile grammarFileName
  case parseOnly parseRule file of
    Left err   -> fail $ "failed to parse " ++ grammarFileName ++ ": " ++ err
    Right rule -> putStrLn $ show rule
