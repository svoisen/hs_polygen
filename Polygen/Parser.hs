module Polygen.Parser (
) where

-------------------------------------------------------------------------------
import           Control.Applicative
import           Data.Attoparsec.ByteString (Parser, takeWhile1, many1, skipMany)
import qualified Data.Attoparsec.ByteString.Char8 as Char8 (char, takeWhile1, string)
import           Data.Char (isAlphaNum)
import           Data.Text (Text)
import           Data.Text.Encoding (decodeUtf8)
import           Polygen.Internal.Attoparsec (skipSpace, skipLine, isQuote, isEOL)
import           Polygen.Types (ExpressionComponent(..), Expression, Rule(..))

-------------------------------------------------------------------------------
--
parseRule :: Parser Rule
parseRule = do
  name <- parseNonTerminal
  skipSpace >> Char8.string "::=" >> skipSpace
  expression <- parseExpression
  return (Rule {name=name, expression=expression})

-------------------------------------------------------------------------------
-- 
parseExpression :: Parser Expression
parseExpression = do
  components <- many1 parseExpressionComponent
  skipSpace >> Char8.char ';'
  return components

-------------------------------------------------------------------------------
--
parseExpressionComponent :: Parser ExpressionComponent
parseExpressionComponent = do
  skipSpace
  component <- parseTerminal <|> parseNonTerminal
  (skipSpace >> Char8.char '|' >> skipSpace) <|> return ()
  return (component)

-------------------------------------------------------------------------------
-- | Parse a non-terminal expression component, surrounded by <> such as
-- | <start>
parseNonTerminal :: Parser ExpressionComponent
parseNonTerminal = do
  name <- Char8.char '<' >> Char8.takeWhile1 isAlphaNum
  Char8.char '>'
  return (NonTerminal $ decodeUtf8 name)

-------------------------------------------------------------------------------
-- | Parse a terminating expression component, surrounded by quotes such as
-- | "foo"
parseTerminal :: Parser ExpressionComponent
parseTerminal = do
  text <- Char8.char '"' >> takeWhile1 (not . isQuote)
  Char8.char '"'
  return (Terminal $ decodeUtf8 text)
