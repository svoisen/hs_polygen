module Polygen.Types ( 
  NonTerminal,
  Terminal,
  Expression,
  Rule,
  Grammar,
  nonTerminal,
) where

-------------------------------------------------------------------------------
import Data.Text (Text)

newtype NonTerminal = NonTerminal Text deriving (Show)
newtype Terminal    = Terminal Text deriving (Show)

data Expression     = NonTerminatingExpression Terminal Expression
                    | TerminatingExpression Terminal
                    deriving (Show)

data Rule = Rule {
  name :: NonTerminal,
  expression :: Expression
}

nonTerminal :: Text -> NonTerminal
nonTerminal = NonTerminal

type Grammar = [Rule]
