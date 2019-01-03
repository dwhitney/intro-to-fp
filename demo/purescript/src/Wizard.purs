module Wizard where

import Prelude

import Component (Component(..))
import UI (class UI)

newtype Wizard ui event props input output = Wizard (Component ui event props input output)

wizard :: forall ui event props input. Wizard ui event props input ~> Component ui event props input
wizard (Wizard component) = component

step :: forall ui event props input. Component ui event props input ~> Wizard ui event props input
step = Wizard

derive instance wizardFunctor :: (UI ui event) => Functor (Wizard ui event props input)

instance wizardBind :: (UI ui event) => Bind (Wizard ui event props i) where
  bind :: forall a b. Wizard ui event props i a -> (a -> Wizard ui event props i b) -> Wizard ui event props i b
  bind (Wizard (Component f)) fab = Wizard (Component (\props i -> do
    let rec = f props i 
    let (Wizard (Component newFn)) = fab rec.result
    newFn props i
  ))
    
instance wizardApply :: (UI ui event) => Apply (Wizard ui event props i) where
  apply :: forall a b. Wizard ui event props i (a -> b) -> Wizard ui event props i a -> Wizard ui event props i b
  apply (Wizard fab) (Wizard fa) = Wizard (apply fab fa)

instance wizardApplicative :: (UI ui event) => Applicative (Wizard ui event props i) where
  pure :: forall a. a -> Wizard ui event props i a
  pure a = Wizard (pure a)

