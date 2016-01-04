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

type Attribs = forall r. {class :: (Maybe String), id :: (Maybe String), style :: (Maybe String) |r}
newtype Node = Node {type :: String, name :: String, children :: Nullable (Array Node), attribs :: Attribs }

foreign import parse :: forall a. Fn2 String (Array Node -> a) Unit

parseHTML :: forall a. String -> (Array Node -> a) -> Unit
parseHTML x cb = runFn2 parse x cb
