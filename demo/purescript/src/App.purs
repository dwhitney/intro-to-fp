module App where

import Prelude

import Component (Component(..), focus)
import Data.Lens.Record (prop)
import Data.Newtype (wrap)
import Data.Symbol (SProxy(..))
import Effect.Console (log) as Console
import Effect.Uncurried (mkEffectFn1)
import Model (Address, Person, _address, _city, _firstName, _lastName, _state, _street, _zip)
import UI (class UI, input)
import Wizard (step, wizard)


addressComponent :: forall ui. UI ui => Component ui Unit Address Address
addressComponent = ado 
 street <- focus _street (textBox mempty) <#> wrap
 city   <- focus _city (textBox mempty) <#> wrap 
 state  <- focus _state (textBox mempty) <#> wrap 
 zip    <- focus _zip (textBox mempty) <#> wrap 
 in { street, city, state, zip }

personComponent :: forall ui. UI ui => Component ui Unit Person Person
personComponent = ado 
  firstName <- focus _firstName (textBox mempty) <#> wrap
  lastName  <- focus _lastName (textBox mempty) <#> wrap
  address   <- focus _address addressComponent
  in { firstName, lastName, address }

textBox :: forall ui . UI ui => String -> Component ui Unit String String 
textBox result = Component \_ i -> 
  { render : \onChange -> input { placeholder : "hi", onChange : mkEffectFn1 $ logit onChange }
  , result
  }
  where
    logit onChange = \str -> do
      Console.log str 
      onChange str


passwordComponent :: forall ui r. UI ui => Component ui Unit { password :: String, passwordConfirmation :: String | r }  String
passwordComponent = wizard do 
  password              <- step $ focus (prop (SProxy :: SProxy "password")) (textBox mempty)
  passwordConfirmation  <- step $ focus (prop (SProxy :: SProxy "passwordConfirmation")) (textBox mempty)
  pure password


