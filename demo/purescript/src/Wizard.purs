module Wizard where

import Prelude

import Component (Component(..))
import UI (class UI)

newtype Wizard ui props input output = Wizard (Component ui props input output)

wizard :: forall ui props input. Wizard ui props input ~> Component ui props input
wizard (Wizard component) = component

step :: forall ui props input. Component ui props input ~> Wizard ui props input
step = Wizard

derive instance wizardFunctor :: (UI ui) => Functor (Wizard ui props input)

instance wizardBind :: (UI ui) => Bind (Wizard ui props i) where
  bind :: forall a b. Wizard ui props i a -> (a -> Wizard ui props i b) -> Wizard ui props i b
  bind (Wizard (Component f)) fab = Wizard (Component (\props i -> do
    let rec = f props i 
    let (Wizard (Component newFn)) = fab rec.result
    newFn props i
  ))
    
instance wizardApply :: (UI ui) => Apply (Wizard ui props i) where
  apply :: forall a b. Wizard ui props i (a -> b) -> Wizard ui props i a -> Wizard ui props i b
  apply (Wizard fab) (Wizard fa) = Wizard (apply fab fa)

instance wizardApplicative :: (UI ui) => Applicative (Wizard ui props i) where
  pure :: forall a. a -> Wizard ui props i a
  pure a = Wizard (pure a)

