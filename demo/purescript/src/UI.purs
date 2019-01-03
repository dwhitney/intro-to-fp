module UI where

import Prelude

import Effect.Uncurried (EffectFn1)
import Prim.Row (class Union)

type EventHandler input = EffectFn1 input Unit 

type InputProps = 
  ( placeholder :: String
  , onChange :: EventHandler String
  )

type LabelProps ui = 
  ( form :: String
  , children :: (Array ui)
  )


class (Semigroup ui, Monoid ui) <= UI ui where

  input 
    :: forall props props_ 
     . Union props props_ InputProps
    => Record props
    -> ui

  label
    :: forall props props_
     . Union props props_ (LabelProps ui)
    => Record props
    -> String
    -> ui


