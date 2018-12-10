module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import App (passwordForm)
import Form (Form)
import Form (run) as Form


type PasswordRecord = { password :: String, passwordConfirmation :: String }
type PasswordForm = Form String Unit PasswordRecord String

main :: Effect Unit
main = do
  let result = go
  log result
  where
    go :: String
    go = do 
      let { result } = Form.run (passwordForm :: PasswordForm ) unit { password : "testPassword", passwordConfirmation: "testPassword" }
      result



