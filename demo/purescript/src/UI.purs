module UI where

import Prelude

import Effect.Uncurried (EffectFn1)
import Prim.Row (class Union)

newtype EventFn a b = EventFn (a -> b)

type EventHandler event = EffectFn1 event Unit 

type InputProps event = 
  ( placeholder :: String
  , onChange :: EventHandler event
  )

class Event event where
  targetValue :: event -> String

class (Semigroup ui, Monoid ui, Event event) <= UI ui event where

  input 
    :: forall props props_ 
     . Union props props_ (InputProps event)
    => Record props
    -> ui


