module React where

import Prelude

import Prim.Row (class Union)
import UI (class UI, InputProps, SharedProps, LabelProps)

foreign import data ReactElement :: Type 

foreign import createElement :: forall r. String -> { | r } -> ReactElement -> ReactElement

foreign import fragment :: Array ReactElement -> ReactElement

foreign import empty :: ReactElement

instance reactElementSemigroup :: Semigroup ReactElement where
  append e1 e2 = fragment [e1, e2]

instance reactElementMonoid :: Monoid ReactElement where
  mempty = empty

instance reactElementUI :: UI ReactElement where
 
  input 
    :: forall props props_
     . Union props props_ (SharedProps InputProps)
    => Record props
    -> ReactElement 
  input props = createElement "input" props empty

  label 
    :: forall props props_
     . Union props props_ (SharedProps (LabelProps ReactElement))
    => Record props
    -> String 
    -> ReactElement 
  label props input = mempty


