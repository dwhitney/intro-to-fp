module Wizard where

import Prelude

import Form (Form(..))

newtype Wizard ui i a = Wizard (Form ui i a)

wizard :: forall ui i. Wizard ui i ~> Form ui i
wizard (Wizard form) = form

step :: forall ui i. Form ui i ~> Wizard ui i
step = Wizard

derive instance wizardFunctor :: (Monoid ui) => Functor (Wizard ui i)

instance wizardBind :: (Monoid ui) => Bind (Wizard ui i) where
  bind :: forall a b. Wizard ui i a -> (a -> Wizard ui i b) -> Wizard ui i b
  bind (Wizard (Form f)) fab = Wizard (Form (\i -> do
    let rec = f i 
    let (Wizard (Form newFn)) = fab rec.result
    newFn i
  ))
    
instance wizardApply :: (Monoid ui) => Apply (Wizard ui i) where
  apply :: forall a b. Wizard ui i (a -> b) -> Wizard ui i a -> Wizard ui i b
  apply (Wizard fab) (Wizard fa) = Wizard (apply fab fa)

instance wizardApplicative :: (Monoid ui) => Applicative (Wizard ui i) where
  pure :: forall a. a -> Wizard ui i a
  pure a = Wizard (pure a)

