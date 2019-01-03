module Component where

import Prelude

import Data.Lens (Lens', set, view)
import Effect (Effect)
import UI (class UI)

type Result ui input output = { render :: (input -> Effect Unit) ->  ui, result :: output }

newtype Component ui event props input output = Component (UI ui event => props -> input -> Result ui input output)

run :: forall ui event props input output. UI ui event => Component ui event props input output -> props -> input -> Result ui input output 
run (Component fn) = fn

focus :: forall ui event props wholeInput focusedInput output. UI ui event => Lens' wholeInput focusedInput -> Component ui event props focusedInput output -> Component ui event props wholeInput output 
focus lens (Component f) = 
  Component \props input -> do 
    let { render, result } = f props (view lens input)
    { render:  \onChange -> render (\j -> onChange (set lens j input))
    , result
    }

instance componentFunctor :: (UI ui event) => Functor (Component ui event props input) where
  map :: forall a b. (a -> b)  -> Component ui event props input a -> Component ui event props input b
  map fn (Component componentFn) = Component (\props input ->
    let { render, result } = componentFn props input
    in { render, result : fn result })

instance componentApply :: (UI ui event) => Apply (Component ui event props input) where
  apply :: forall a b. Component ui event props input (a -> b) -> Component ui event props input a -> Component ui event props input b
  apply (Component fnAB) (Component fnA) = Component (\props input -> do
    let recAB = fnAB props input
    let recA = fnA props input
    let render = \onChange -> (recAB.render onChange) <> (recA.render onChange) 
    { render, result : recAB.result recA.result })

instance componentApplicative :: (UI ui event) => Applicative (Component ui event props input) where
  pure :: forall a. a -> Component ui event props input a
  pure result = Component (\_ _ -> { render : (\_ -> mempty), result } )



