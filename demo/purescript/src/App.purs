module App where

import Prelude

import Data.Lens.Record (prop)
import Data.Newtype (wrap)
import Data.Symbol (SProxy(..))
import Form (Form, focus, textBox)
import Model (Address, Person, _address, _city, _firstName, _lastName, _state, _street, _zip)
import Wizard (step, wizard)


addressForm :: forall ui. Monoid ui => Form ui Unit Address Address
addressForm = ado 
 street <- focus _street (textBox "") <#> wrap
 city   <- focus _city (textBox "") <#> wrap 
 state  <- focus _state (textBox "") <#> wrap 
 zip    <- focus _zip (textBox "") <#> wrap 
 in { street, city, state, zip }

personForm :: forall ui. Monoid ui => Form ui Unit Person Person
personForm = ado 
  firstName <- focus _firstName (textBox "") <#> wrap
  lastName <- focus _lastName (textBox "") <#> wrap
  address  <- focus _address addressForm
  in { firstName, lastName, address }


passwordForm :: forall ui r. Monoid ui => Form ui Unit { password :: String, passwordConfirmation :: String | r }  String
passwordForm = wizard do 
  password <- step $ focus (prop (SProxy :: SProxy "password")) (textBox "hi")
  passwordConfirmation <- step $
    focus (prop (SProxy :: SProxy "passwordConfirmation")) (textBox "")
  pure password
