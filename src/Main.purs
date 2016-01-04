module Main where

import Prelude
import Control.Monad.Eff.Console
import Control.Monad.Eff
import Data.Foldable(foldr)
import Data.String (joinWith, trim, split)
import Data.Nullable (Nullable(), toMaybe, toNullable)
import Data.Maybe
import Data.Array (length)
import CSS (ParseTree(), Rule(), parse, rules)
import HTML (Node(..), parseHTML)
import Node.FS.Sync (readFile)
import qualified Node.Buffer as Buffer
import qualified Node.Encoding as Encoding

type Tag = String
type Identifier = String
type ClassName = String

newtype Selectors = Selectors {id :: Identifier, classes :: (Array ClassName), tag :: Tag }
newtype Style = Style { key :: String, value :: String }
newtype StyledNode = StyledNode { type :: String, name :: String, children :: Nullable (Array Node), style :: Array Style, selectors :: Selectors }

--readIt :: forall eff. String -> Eff (fs :: FS, err :: EXCEPTION | eff) String
readIt = ((<$>) (Buffer.toString Encoding.UTF8)) <<< readFile

-- styles css  = 
-- return dom.filter(function(n){ return n.type !== "directive"}).map(function(c){ return attachAllStyles({style: root}, c, rules)});
--    if(node.attribs['class']) _selectors.classes = node.attribs['class'].split(' ').map(function(x){ return '.'+_.trim(x) })

addSelectors :: Array Rule -> Node -> StyledNode
addSelectors rs (Node node) = StyledNode {type: "", name: "gus", children: toNullable Nothing, style: [], selectors: Selectors {id: "", classes: (toClass <$> classes), tag: ""} }
  where
    classes = node.attribs.class
    toClass str = ((<$>) \x -> "."++ (trim x)) <<< split " " $ str

attachStyles :: Array Rule -> Array Node -> Array StyledNode
attachStyles rs nodes = (addSelectors rs) <$> nodes

getTypes :: Array Node -> Array String
getTypes ns = (\(Node x) -> x.name) <$> ns

showTags :: ParseTree -> Array String
showTags p = (\x -> maybe "" (joinWith ",") <<< toMaybe $ x.selectors) <$> p.stylesheet.rules

showNodes :: Array Node -> String
showNodes ps = foldr sho "" ps
    where
      sho (Node x) acc = (maybe x.name showNodes (toMaybe x.children)) ++ "\n" ++ acc

getRules :: String -> Array Rule
getRules = rules <<< parse

main = do
  rules <- ((<$>) getRules) <<< readIt $ "easy.css"
  html <- readIt "easy.html"
  let _blah = parseHTML html (log <<< (attachStyles rules))
  log "done!"
