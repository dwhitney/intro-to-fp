module Wizard where

import Prelude

import Component (Component(..))
import UI (class UI)

newtype Wizard ui event input output = Wizard (Component ui event input output)

wizard :: forall ui event input. Wizard ui event input ~> Component ui event input
wizard (Wizard component) = component

step :: forall ui event input. Component ui event input ~> Wizard ui event input
step = Wizard

derive instance wizardFunctor :: (UI ui event) => Functor (Wizard ui event input)

instance wizardBind :: (UI ui event) => Bind (Wizard ui event i) where
  bind :: forall a b. Wizard ui event i a -> (a -> Wizard ui event i b) -> Wizard ui event i b
  bind (Wizard (Component f)) fab = Wizard (Component (\i -> do
    let rec = f i 
    let (Wizard (Component newFn)) = fab rec.result
    newFn i
  ))
    
instance wizardApply :: (UI ui event) => Apply (Wizard ui event i) where
  apply :: forall a b. Wizard ui event i (a -> b) -> Wizard ui event i a -> Wizard ui event i b
  apply (Wizard fab) (Wizard fa) = Wizard (apply fab fa)

instance wizardApplicative :: (UI ui event) => Applicative (Wizard ui event i) where
  pure :: forall a. a -> Wizard ui event i a
  pure a = Wizard (pure a)

