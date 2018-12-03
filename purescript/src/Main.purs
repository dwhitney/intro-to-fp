module Main where

import Prelude

import Day1.Main (foo) as Day1
import Effect (Effect)
import Effect.Console (logShow)

main :: Effect Unit
main = do
  logShow $ Day1.foo "asdf" 
  logShow $ Day1.foo 5
