module UI where

import Prelude

import Effect.Uncurried (EffectFn1)
import Prim.Row (class Union)

type EventHandler event = EffectFn1 event Unit

type SharedProps specific event =
  ( onChange  :: EventHandler event
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


class (Semigroup ui, Monoid ui) <= UI ui event where

  input 
    :: forall props props_ 
     . Union props props_ (SharedProps InputProps event)
    => Record props
    -> ui

  label
    :: forall props props_
     . Union props props_ (SharedProps (LabelProps ui) event)
    => Record props
    -> String
    -> ui


