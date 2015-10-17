module Test.Main where

import Prelude
import Control.Monad.Eff.Console

import Test.Unit

main = do
  runTest do
    test "arithmetic" do
      assert "two plus two isn't four" $ (2 + 2) == 4
      assertFalse "two plus two is five" $ (2 + 2) == 5
