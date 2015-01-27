{-# LANGUAGE TemplateHaskell #-}
module Language.SillyStack.Instructions where

import Control.Lens
import Control.Monad.State

data Thing = TInt Integer
           | TInstruction Instruction
           deriving (Eq, Ord, Show)

data Instruction = PUSH Thing
                 | POP
                 | ADD
                 deriving (Eq, Ord, Show)

data SillyState = SillyState {
    _stack :: [Thing]
    --, _programCounter :: Integer
} deriving (Eq, Ord, Show)

makeLenses ''SillyState

emptyState :: SillyState
emptyState = SillyState []

type SillyVMT a = StateT SillyState IO a

push :: Thing -> SillyVMT ()
push t = do
  s <- use stack
  stack .= t : s

pop :: SillyVMT Thing
pop = do
  s <- use stack
  stack .= init s
  return . last $ s

add :: SillyVMT ()
add = do
  TInt x1 <- pop
  TInt x2 <- pop
  s <- use stack
  stack .= (TInt (x1 + x2)) : s
