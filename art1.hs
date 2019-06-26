-- https://ideone.com/7hBc7i
main = print$f [[1,2],[3,4]]
f=foldr ((<*>).map (:)) [[]]
{-
珠玉のリスト・プログラミング - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20081208/1228727709
関数合成の妙技 - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20100702/1278036842
yuwki0131-blog: Haskellのリスト操作関数リストアップ(一覧)
https://uid0130.blogspot.com/2014/07/haskell.html
お気楽 Haskell プログラミング入門 Applicative
http://www.nct9.ne.jp/m_hiroi/func/haskell14.html
箱で考えるFunctor、ApplicativeそしてMonad - Qiita
https://qiita.com/suin/items/0255f0637921dcdfe83b
-}
