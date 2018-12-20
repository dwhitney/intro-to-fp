module Component where

import Prelude

import Data.Lens (Lens', set, view)
import Effect (Effect)
import UI (class UI)

type Result ui input output = { render :: (input -> Effect Unit) ->  ui, result :: output }

newtype Component ui props input output = Component (UI ui => props -> input -> Result ui input output)

run :: forall ui props input output. UI ui => Component ui props input output -> props -> input -> Result ui input output 
run (Component fn) = fn

focus :: forall ui props wholeInput focusedInput output. UI ui => Lens' wholeInput focusedInput -> Component ui props focusedInput output -> Component ui props wholeInput output 
focus lens (Component f) = 
  Component \props input -> do 
    let { render, result } = f props (view lens input)
    { render:  \onChange -> render (onChange <<< flip (set lens) input)
    , result
    }

instance componentFunctor :: (UI ui) => Functor (Component ui props input) where
  map :: forall a b. (a -> b)  -> Component ui props input a -> Component ui props input b
  map fn (Component componentFn) = Component (\props input ->
    let { render, result } = componentFn props input
    in { render, result : fn result })

instance componentApply :: (UI ui) => Apply (Component ui props input) where
  apply :: forall a b. Component ui props input (a -> b) -> Component ui props input a -> Component ui props input b
  apply (Component fnAB) (Component fnA) = Component (\props input -> do
    let recAB = fnAB props input
    let recA = fnA props input
    recA { result = recAB.result recA.result })

instance componentApplicative :: (UI ui) => Applicative (Component ui props input) where
  pure :: forall a. a -> Component ui props input a
  pure result = Component (\_ _ -> { render : (\_ -> mempty), result } )



