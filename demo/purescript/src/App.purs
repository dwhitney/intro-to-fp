module App where

import Prelude

import Component (Component(..), focus)
import Data.Lens.Record (prop)
import Data.Newtype (wrap)
import Data.Symbol (SProxy(..))
import Model (Address, Person, _address, _city, _firstName, _lastName, _state, _street, _zip)
import UI (class UI)
import Wizard (step, wizard)


addressComponent :: forall ui event. UI ui event => Component ui event Unit Address Address
addressComponent = ado 
 street <- focus _street (textBox mempty) <#> wrap
 city   <- focus _city (textBox mempty) <#> wrap 
 state  <- focus _state (textBox mempty) <#> wrap 
 zip    <- focus _zip (textBox mempty) <#> wrap 
 in { street, city, state, zip }

personComponent :: forall ui event. UI ui event => Component ui event Unit Person Person
personComponent = ado 
  firstName <- focus _firstName (textBox mempty) <#> wrap
  lastName  <- focus _lastName (textBox mempty) <#> wrap
  address   <- focus _address addressComponent
  in { firstName, lastName, address }

textBox :: forall ui event. UI ui event => String -> Component ui event Unit String String 
textBox result = Component \props i -> 
  { render : \onChange -> mempty
  , result
  }

passwordComponent :: forall ui event r. UI ui event => Component ui event Unit { password :: String, passwordConfirmation :: String | r }  String
passwordComponent = wizard do 
  password              <- step $ focus (prop (SProxy :: SProxy "password")) (textBox mempty)
  passwordConfirmation  <- step $ focus (prop (SProxy :: SProxy "passwordConfirmation")) (textBox mempty)
  pure password


