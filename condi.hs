{-# LANGUAGE OverloadedStrings #-}

-- 03. Conduitでコンソールアプリケーション
-- https://sites.google.com/site/toriaezuzakki/haskell/conduit-console

-- Data.Conduit
-- https://hackage.haskell.org/package/conduit-1.3.4.3/docs/Data-Conduit.html

-- Data.Conduit.Lift
-- https://hackage.haskell.org/package/conduit-1.3.4.3/docs/Data-Conduit-Lift.html

import Text.Read(readMaybe)
import Data.Conduit
import qualified Data.Conduit.Combinators as C
import Data.Text
import Data.Text.Lazy (toStrict)
import Data.Text.Lazy.Builder
import Data.Text.Lazy.Builder.Int
import Control.Applicative
import Control.Monad.Trans.Maybe(MaybeT)
import Data.Conduit.Lift

awaitInt :: Monad m => ConduitT Text Text (MaybeT m) Int
awaitInt = maybeC await >>= go
  where
    go t = case (readMaybe. unpack $t:: Maybe Int) of
        Just i -> return i
        Nothing -> yield "数字ではありません。再入力してください。" >> awaitInt

awaitIntDouble :: Monad m => ConduitT Text Text (MaybeT m) (Int, Int)
awaitIntDouble = (,) <$>
    (yield "1番目の数値を入力してください。" *> awaitInt) <*>
    (yield "2番目の数値を入力してください。" *> awaitInt)

appConduit :: Monad m => ConduitT Text Text m ()
appConduit = runMaybeC awaitIntDouble >>= maybe (yield "END") go
  where
    go (fst,snd) = (yield. toStrict. toLazyText $
            (decimal $ fst) <> fromString "+" <>
            (decimal $ snd) <> fromString "の答えは" <>
            (decimal $ (fst) + (snd)) <> fromString "です。")
        >> appConduit

main :: IO ()
main =runConduit $ C.stdin
            .| C.decodeUtf8
            .| C.linesUnbounded
            .| appConduit
            .| C.unlines
            .| C.encodeUtf8
            .| C.stdout
