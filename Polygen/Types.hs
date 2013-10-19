module Polygen.Types ( 
  ExpressionComponent(..),
  Expression,
  Terminal,
  NonTerminal,
  Rule(..),
  RuleName,
  Grammar
) where

-------------------------------------------------------------------------------
import Data.Text (Text)

newtype RuleName = RuleName Text deriving (Show)
newtype Terminal = Terminal Text deriving (Show)
newtype NonTerminal = NonTerminal Text deriving (Show)

data ExpressionComponent = TerminalComponent Terminal
                         | NonTerminalComponent NonTerminal
                         deriving (Show)

type Expression = [ExpressionComponent]

data Rule = Rule {
  name :: NonTerminal,
  expression :: Expression
} deriving (Show)

type Grammar = [Rule]
