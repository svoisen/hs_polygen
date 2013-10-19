module Polygen.Internal.Attoparsec (
  skipSpace,
  skipLine,
  isQuote,
  isEOL,
) where

-------------------------------------------------------------------------------
import Data.Attoparsec.ByteString (Parser, skipWhile)
import Data.Word8 (Word8, isSpace)

-------------------------------------------------------------------------------
-- | Skip all whitespace
skipSpace :: Parser ()
skipSpace = skipWhile isSpace

-------------------------------------------------------------------------------
-- | Is quotation
isQuote :: Word8 -> Bool
isQuote c = c == 34

-------------------------------------------------------------------------------
-- | True if the given @Word8@ is an end of line character.
isEOL :: Word8 -> Bool
isEOL x = x == 10 || x == 13

-------------------------------------------------------------------------------
-- |
skipLine :: Parser ()
skipLine = skipWhile (not . isEOL) >> skipSpace
