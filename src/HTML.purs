module HTML where

import Prelude
import Control.Monad.Eff.Console
import Control.Monad.Eff
import Control.Monad
import Data.Either
import Data.Maybe
import Data.Nullable
import Data.Function

data Error a = Error a

newtype Node = Node {type :: String, name :: String, children :: Nullable (Array Node) }

foreign import parse :: forall a. Fn2 String (Array Node -> a) Unit

parseHTML :: forall a. String -> (Array Node -> a) -> Unit
parseHTML x cb = runFn2 parse x cb
