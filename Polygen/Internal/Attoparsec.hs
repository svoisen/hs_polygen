module Polygen.Internal.Attoparsec (
  skipSpace
) where

-------------------------------------------------------------------------------
import Data.Attoparsec.ByteString (Parser, skipWhile)
import Data.Word8 (isSpace)

-------------------------------------------------------------------------------
-- | Skip all whitespace
skipSpace :: Parser ()
skipSpace = skipWhile isSpace
