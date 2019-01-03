module App where

import Prelude

import Component (Component(..), focus)
import Data.Lens.Record (prop)
import Data.Newtype (wrap)
import Data.Symbol (SProxy(..))
import Effect (Effect)
import Effect.Console (log)
import Effect.Uncurried (mkEffectFn1)
import Model (Address, Person, _address, _city, _firstName, _lastName, _state, _street, _zip)
import UI (class Event, class UI, EventHandler, input, targetValue)
import Wizard (step, wizard)


addressComponent :: forall ui event. UI ui event => Component ui event Unit Address Address
addressComponent = ado 
 street <- focus _street (textBox) <#> wrap
 city   <- focus _city (textBox) <#> wrap 
 state  <- focus _state (textBox) <#> wrap 
 zip    <- focus _zip (textBox) <#> wrap 
 in { street, city, state, zip }

personComponent :: forall ui event. UI ui event => Component ui event Unit Person Person
personComponent = ado 
  firstName <- focus _firstName (textBox) <#> wrap
  lastName  <- focus _lastName (textBox) <#> wrap
  address   <- focus _address addressComponent
  in { firstName, lastName, address }

textBox :: forall ui event. UI ui event => Event event => Component ui event Unit String String 
textBox = Component \props i -> 
  { render : \onChange -> input { placeholder : "hi", onChange : logit onChange }
  , result : i
  }
  where
    logit :: (String -> Effect Unit) -> EventHandler event
    logit onChange = mkEffectFn1 $ \event -> do
      let str = targetValue event
      log str
      onChange str

passwordComponent :: forall ui event r. UI ui event => Component ui event Unit { password :: String, passwordConfirmation :: String | r }  String
passwordComponent = wizard do 
  password              <- step $ focus (prop (SProxy :: SProxy "password")) (textBox)
  passwordConfirmation  <- step $ focus (prop (SProxy :: SProxy "passwordConfirmation")) (textBox)
  pure password


