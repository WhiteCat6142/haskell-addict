-- https://qiita.com/algas/items/e201773601eccac97e1e
-- hpack と hspec に対応した stack templates - Qiita

import Test.Hspec

import Data.Num.Fib

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "fib" $ do
        it "fib 80" $ do
            fib 80 `shouldBe` 23416728348467685

