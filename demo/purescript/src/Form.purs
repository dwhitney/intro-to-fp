module Form where

import Prelude

import Data.Lens (Lens', set, view)
import Effect (Effect)

type Result ui i a = { render :: (i -> Effect Unit) ->  ui, result :: a }

newtype Form ui props i a = Form (Monoid ui => props -> i -> Result ui i a)

run :: forall ui props i a. Monoid ui => Form ui props i a -> props -> i -> Result ui i a
run (Form fn) = fn

focus :: forall ui props i j a. Monoid ui => Lens' i j -> Form ui props j a -> Form ui props i a
focus lens (Form f) = 
  Form \props i -> do 
    let { render, result } = f props (view lens i)
    { render:  \onChange -> render (onChange <<< flip (set lens) i)
    , result
    }

textBox :: forall ui i o. Monoid ui => o -> Form ui Unit i o 
textBox result = Form \i _ -> 
  { render : \onChange -> mempty
  , result
  }

instance formFunctor :: (Monoid ui) => Functor (Form ui props i) where
  map :: forall a b. (a -> b)  -> Form ui props i a -> Form ui props i b
  map fn (Form formFn) = Form (\props i ->
    let { render, result } = formFn props i
    in { render, result : fn result })

instance formApply :: (Monoid ui) => Apply (Form ui props i) where
  apply :: forall a b. Form ui props i (a -> b) -> Form ui props i a -> Form ui props i b
  apply (Form fnAB) (Form fnA) = Form (\props i -> do
    let recAB = fnAB props i
    let recA = fnA props i
    recA { result = recAB.result recA.result })

instance formApplicative :: (Monoid ui) => Applicative (Form ui props i) where
  pure :: forall a. a -> Form ui props i a
  pure result = Form (\_ _ -> { render : (\_ -> mempty), result } )

