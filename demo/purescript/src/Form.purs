module Form where

import Prelude

import Data.Lens (Lens', set, view)
import Effect (Effect)

type Result ui i a = { render :: (i -> Effect Unit) ->  ui, result :: a }

newtype Form ui i a = Form (Monoid ui => i -> Result ui i a)

run :: forall ui i a. Monoid ui => Form ui i a -> i -> Result ui i a
run (Form fn) = fn

focus :: forall ui i j a. Monoid ui => Lens' i j -> Form ui j a -> Form ui i a
focus lens (Form f) = 
  Form \i -> do 
    let { render, result } = f (view lens i)
    { render:  \onChange -> render (onChange <<< flip (set lens) i)
    , result
    }

textBox :: forall ui i o. Monoid ui => o -> Form ui i o 
textBox result = Form \i -> 
  { render : \onChange -> mempty
  , result
  }

instance formFunctor :: (Monoid ui) => Functor (Form ui i) where
  map :: forall a b. (a -> b)  -> Form ui i a -> Form ui i b
  map fn (Form formFn) = Form (\i ->
    let { render, result } = formFn i
    in { render, result : fn result })

instance formApply :: (Monoid ui) => Apply (Form ui i) where
  apply :: forall a b. Form ui i (a -> b) -> Form ui i a -> Form ui i b
  apply (Form fnAB) (Form fnA) = Form (\i -> do
    let recAB = fnAB i
    let recA = fnA i
    recA { result = recAB.result recA.result })

instance formApplicative :: (Monoid ui) => Applicative (Form ui i) where
  pure :: forall a. a -> Form ui i a
  pure result = Form (\_ -> { render : (\_ -> mempty), result } )

