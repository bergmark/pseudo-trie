module Data.Trie.PseudoSpec (main, spec) where

import           Data.Trie.Pseudo
import qualified Data.Trie.Pseudo          as P

import           Data.List.NonEmpty
import qualified Data.List.NonEmpty        as NE
import           Prelude                   hiding (lookup)
import           Test.Hspec
import           Test.Hspec.QuickCheck
import           Test.QuickCheck
import           Test.QuickCheck.Instances

main :: IO ()
main = hspec spec

-- TODO:
--   - Overwriting
--   - Forking two Rests at their divergent point
--   - fromAssocs . toAssocs == normalize
--   - making a new root node...?
--      - implicit optional root node :\ bad idea

spec :: Spec
spec = do
  describe "reconstruction" $ do
    prop "`fromAssocs . toAssocs` should homomorphically `prune`" fromToPrune

fromToPrune :: PseudoTrie String Int -> Property
fromToPrune trie = (fromAssocs $ toAssocs $ prune trie)
               === (prune $ fromAssocs $ toAssocs trie)
