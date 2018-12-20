module UI where

import Prelude

import Effect (Effect)

type TextProps =
  { onFocus   :: String -> Effect Unit
  , onBlur    :: String -> Effect Unit
  , onChange  :: String -> Effect Unit
  }


class Monoid ui <= UI ui where
  text :: TextProps -> String -> ui

instance stringUI :: UI String where
  text :: TextProps -> String -> String
  text props input = input


