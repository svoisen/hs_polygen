module Polygen.Parser (
  parseNonTerminal
) where

-------------------------------------------------------------------------------
import Data.Text (Text)
import Data.Char (isAlphaNum)
import Data.Attoparsec.ByteString (Parser)
import Data.Attoparsec.ByteString.Char8 (char, takeWhile1)
import Data.Text.Encoding (decodeUtf8)
import Polygen.Types (NonTerminal, nonTerminal)
import Polygen.Internal.Attoparsec (skipSpace)

-------------------------------------------------------------------------------
-- | Parse a non-terminal expression component, surrounded by <> such as
-- | <start>
parseNonTerminal :: Parser NonTerminal
parseNonTerminal = do
  name <- char '<' >> takeWhile1 isAlphaNum
  char '>'
  return (nonTerminal $ decodeUtf8 name)
