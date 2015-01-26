module Language.SillyStack.Instructions where

data Thing = TInt Integer
           deriving (Eq, Ord, Show)

data Instruction = PUSH Thing
                 | POP
                 | ADD
                 deriving (Eq, Ord, Show)
