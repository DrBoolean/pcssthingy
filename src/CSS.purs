module CSS where

import Prelude
import Data.Nullable
import Data.Function

type Declaration = { property :: String, value :: String }
type Rule = { selectors :: Nullable (Array String), declarations :: Array Declaration }
type Stylesheet = { rules :: Array Rule }
type ParseTree = {stylesheet :: Stylesheet, parsingErrors :: Array String}

foreign import parseImpl :: forall opts. Fn2 String { | opts } ParseTree

rules :: ParseTree -> Array Rule
rules x = x.stylesheet.rules

parse :: String -> ParseTree
parse x = runFn2 parseImpl x {}
