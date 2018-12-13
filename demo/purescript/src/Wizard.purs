module Wizard where

import Prelude

import Form (Form(..))
import UI (class UI)

newtype Wizard ui props i a = Wizard (Form ui props i a)

wizard :: forall ui props i. Wizard ui props i ~> Form ui props i
wizard (Wizard form) = form

step :: forall ui props i. Form ui props i ~> Wizard ui props i
step = Wizard

derive instance wizardFunctor :: (UI ui) => Functor (Wizard ui props i)

instance wizardBind :: (UI ui) => Bind (Wizard ui props i) where
  bind :: forall a b. Wizard ui props i a -> (a -> Wizard ui props i b) -> Wizard ui props i b
  bind (Wizard (Form f)) fab = Wizard (Form (\props i -> do
    let rec = f props i 
    let (Wizard (Form newFn)) = fab rec.result
    newFn props i
  ))
    
instance wizardApply :: (UI ui) => Apply (Wizard ui props i) where
  apply :: forall a b. Wizard ui props i (a -> b) -> Wizard ui props i a -> Wizard ui props i b
  apply (Wizard fab) (Wizard fa) = Wizard (apply fab fa)

instance wizardApplicative :: (UI ui) => Applicative (Wizard ui props i) where
  pure :: forall a. a -> Wizard ui props i a
  pure a = Wizard (pure a)

