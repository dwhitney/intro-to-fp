module UI where

import Prelude

import Effect (Effect)
import Prim.Row (class Union)

type SharedProps specific =
  ( onFocus   :: String -> Effect Unit
  , onBlur    :: String -> Effect Unit
  , onChange  :: String -> Effect Unit
  , onClick   :: String -> Effect Unit
  | specific
  )

type InputProps = 
  ( placeholder :: String
  , type        :: String
  , value       :: String
  )

type LabelProps ui = 
  ( form :: String
  , children :: (Array ui)
  )


class Monoid ui <= UI ui where
  
  input 
    :: forall props props_ 
     . Union props props_ (SharedProps InputProps)
    => Record props
    -> ui

  label
    :: forall props props_
     . Union props props_ (SharedProps (LabelProps ui))
    => Record props
    -> String
    -> ui

  


instance stringUI :: UI String where
  
  input 
    :: forall props props_
     . Union props props_ (SharedProps InputProps)
    => Record props
    -> String 
  input props = mempty

  label 
    :: forall props props_
     . Union props props_ (SharedProps (LabelProps String))
    => Record props
    -> String 
    -> String 
  label props input = mempty



