module React where

import Prelude

import Prim.Row (class Union)
import UI (class Event, class UI, InputProps)

foreign import data ReactElement :: Type 

foreign import data SyntheticEvent :: Type

instance eventSyntheticEvent :: Event SyntheticEvent where
  targetValue = _targetValue

foreign import createElement :: forall r. String -> { | r } -> ReactElement -> ReactElement

foreign import empty :: ReactElement

foreign import fragment :: Array ReactElement -> ReactElement

foreign import _targetValue :: SyntheticEvent -> String


instance reactElementSemigroup :: Semigroup ReactElement where
  append e1 e2 = fragment [e1, e2]

instance reactElementMonoid :: Monoid ReactElement where
  mempty = empty

instance reactElementUI :: UI ReactElement SyntheticEvent where
 
  input 
    :: forall props props_
     . Union props props_ (InputProps SyntheticEvent)
    => Record props
    -> ReactElement 
  input props = createElement "input" props empty

