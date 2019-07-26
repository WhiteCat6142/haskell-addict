-- https://ideone.com/chXQ04
{-# LANGUAGE BangPatterns #-}
import System.Random
randomSeq :: Int -> [Int] 
randomSeq seed = randomRs (0,10000) (mkStdGen seed)
bsort (x:xs)=foldr bs [x] xs
 where bs !x (!y:ys)|x<=y =(x:y:ys)
                  |otherwise =(y:bs x ys)
main=print.bsort.take 10000.randomSeq$1234

-- https://ideone.com/r4bLq1
-- https://gist.github.com/WhiteCat6142/a3270468cbf829200b7f66acd048b1a2

{-
疑似乱数に状態なんていらない - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20101004/1286158698
右も左も分かる再帰 - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20110908/1315473844
遅延評価と末尾再帰と余再帰 - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20091122/1258899591
foldlを直す - 純粋関数空間
http://tanakh.jp/posts/2014-04-07-foldl-is-broken.html
-}
