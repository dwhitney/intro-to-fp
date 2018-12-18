module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import App (passwordComponent)
import Component (Component)
import Component (run) as Component


type PasswordRecord = { password :: String, passwordConfirmation :: String }
type PasswordComponent = Component String Unit PasswordRecord String

main :: Effect Unit
main = do
  let result = go
  log result
  where
    go :: String
    go = do 
      let { result } = Component.run (passwordComponent :: PasswordComponent ) unit { password : "testPassword", passwordConfirmation: "testPassword" }
      result



