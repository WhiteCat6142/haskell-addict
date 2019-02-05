-- https://ideone.com/r4bLq1
-- https://gist.github.com/WhiteCat6142/a3270468cbf829200b7f66acd048b1a2
import System.Random
randomSeq :: Int -> [Int] 
randomSeq seed = randomRs (0,10000) (mkStdGen seed)
bsort=foldr bs []
 where bs x []=[x]
       bs x (y:ys)|x<=y =(x:y:ys)
                  |otherwise =(y:bs x ys)
main=print.bsort.take 10000.randomSeq$1234

{-
疑似乱数に状態なんていらない - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20101004/1286158698
右も左も分かる再帰 - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20110908/1315473844
-}
