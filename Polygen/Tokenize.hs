module Polygen.Tokenize
( tokenize'
) where

import Data.List.Split as S

tokenize' :: String -> [String] -> [String]
tokenize' xs acc 
  | length xs == 0 = acc
  | otherwise = tokenize' (drop tokenLength xs) (acc ++ [token])
      where token       = takeWhile (/= '"') xs
            tokenLength = length token 
  
