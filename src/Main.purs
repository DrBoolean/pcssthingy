module Main where

import Prelude
import Control.Monad.Eff.Console
import Control.Monad.Eff
import Data.Foldable(foldr)
import Data.String (joinWith)
import Data.Nullable (toMaybe)
import Data.Maybe (maybe)
import Data.Array (length)
import CSS (ParseTree(), parse)
import HTML (Node(..), parseHTML)
import Node.FS.Sync (readFile)
import qualified Node.Buffer as Buffer
import qualified Node.Encoding as Encoding

--readIt :: forall eff. String -> Eff (fs :: FS, err :: EXCEPTION | eff) String
readIt = ((<$>) (Buffer.toString Encoding.UTF8)) <<< readFile

-- styles css  = 
-- return dom.filter(function(n){ return n.type !== "directive"}).map(function(c){ return attachAllStyles({style: root}, c, rules)});

getTypes :: Array Node -> Array String
getTypes ns = (\(Node x) -> x.name) <$> ns

showTags :: ParseTree -> Array String
showTags p = (\x -> maybe "" (joinWith ",") <<< toMaybe $ x.selectors) <$> p.stylesheet.rules

showNodes :: Array Node -> String
showNodes ps = foldr sho "" ps
    where
      sho (Node x) acc = (maybe x.name showNodes (toMaybe x.children)) ++ "\n" ++ acc

main = do
  css <- readIt "easy.css"
  h <- readIt "easy.html"
  let e = parseHTML h (showNodes >>> log)
  let tags = joinWith "---" <<< showTags <<< parse $ css
  log tags
