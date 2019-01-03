module Component where

import Prelude

import Data.Lens (Lens', set, view)
import Debug.Trace (spy)
import Effect (Effect)
import UI (class UI)

type Result ui input output = { render :: (input -> Effect Unit) ->  ui, result :: output }

newtype Component ui event input output = Component (UI ui event => input -> Result ui input output)

run :: forall ui event input output. UI ui event => Component ui event input output -> input -> Result ui input output 
run (Component fn) = fn

focus :: forall ui event wholeInput focusedInput output. UI ui event => Lens' wholeInput focusedInput -> Component ui event focusedInput output -> Component ui event wholeInput output 
focus lens (Component f) = 
  Component \input -> do 
    let { render, result } = f (view lens input)
    { render:  \onChange -> render (\j -> onChange (set lens j input) >>= (const $ do
          let s = spy "focus" input 
          pure unit))
    , result
    }

instance componentFunctor :: (UI ui event) => Functor (Component ui event input) where
  map :: forall a b. (a -> b)  -> Component ui event input a -> Component ui event input b
  map fn (Component componentFn) = Component (\input ->
    let { render, result } = componentFn input
    in { render, result : fn result })

instance componentApply :: (UI ui event) => Apply (Component ui event input) where
  apply :: forall a b. Component ui event input (a -> b) -> Component ui event input a -> Component ui event input b
  apply (Component fnAB) (Component fnA) = Component (\input -> do
    let recAB = fnAB input
    let recA = fnA input
    let render = \onChange -> (recAB.render onChange) <> (recA.render onChange) 
    { render, result : recAB.result recA.result })

instance componentApplicative :: (UI ui event) => Applicative (Component ui event input) where
  pure :: forall a. a -> Component ui event input a
  pure result = Component (\_ -> { render : (\_ -> mempty), result } )



