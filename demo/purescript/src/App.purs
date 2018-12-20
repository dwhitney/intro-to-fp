module App where

import Prelude

import Component (Component(..), focus)
import Data.Lens.Record (prop)
import Data.Newtype (wrap)
import Data.Symbol (SProxy(..))
import Model (Address, Person, _address, _city, _firstName, _lastName, _state, _street, _zip)
import UI (class UI, TextProps, text)
import Wizard (step, wizard)


addressComponent :: forall ui. UI ui => Component ui Unit Address Address
addressComponent = ado 
 street <- focus _street (textBox "") <#> wrap
 city   <- focus _city (textBox "") <#> wrap 
 state  <- focus _state (textBox "") <#> wrap 
 zip    <- focus _zip (textBox "") <#> wrap 
 in { street, city, state, zip }

personComponent :: forall ui. UI ui => Component ui Unit Person Person
personComponent = ado 
  firstName <- focus _firstName (textBox "") <#> wrap
  lastName  <- focus _lastName (textBox "") <#> wrap
  address   <- focus _address addressComponent
  in { firstName, lastName, address }

emptyTextProps :: TextProps
emptyTextProps = { onBlur : const $ pure unit, onFocus : const $ pure unit, onChange : const $ pure unit }

textBox :: forall ui. UI ui => String -> Component ui Unit String String 
textBox result = Component \_ i -> 
  { render : \onChange -> text emptyTextProps i
  , result
  }

passwordComponent :: forall ui r. UI ui => Component ui Unit { password :: String, passwordConfirmation :: String | r }  String
passwordComponent = wizard do 
  password              <- step $ focus (prop (SProxy :: SProxy "password")) (textBox "hi")
  passwordConfirmation  <- step $ focus (prop (SProxy :: SProxy "passwordConfirmation")) (textBox "")
  pure password


