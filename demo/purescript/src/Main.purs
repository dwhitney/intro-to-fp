module Main where

import Prelude

import App (addressComponent) as App
import App (passwordComponent, textBox)
import Component (Component)
import Component (run) as Component
import Effect (Effect)
import Effect.Console (log)
import Model (Address, City(..), State(..), Street(..), Zip(..))
import React (ReactElement)
import React.Basic (JSX)


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

app :: Effect ReactElement 
app = do
  let address = { street : Street "street", city : City "city", state : State "NY", zip : Zip "11205" }
  let fn = Component.run lessSimple 
  pure $ (fn unit address).render (const $ pure unit)
-- pure $ ((Component.run simple) unit "Yo!").render (\str -> log str)
--app = pure $ R.input { type : "text", placeholder : "hello, world!" }


lessSimple :: Component ReactElement Unit Address Address
lessSimple = App.addressComponent

simple :: Component JSX Unit String Unit
simple = ado 
  _ <- textBox "Hi!"
  _ <- textBox "Bye!"
  in unit
