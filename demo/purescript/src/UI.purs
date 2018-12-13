module UI where

import Prelude


class Monoid ui <= UI ui 

instance stringUI :: UI String

