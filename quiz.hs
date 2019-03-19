{-
https://mevius.5ch.net/test/read.cgi/tech/1540901846/l50
https://gist.github.com/WhiteCat6142/8ad00596e6a5fb0620f4f9921f3b16e9
https://ideone.com/8v0bEW
-}

import Control.Monad
import System.IO
main=setting>>zipWithM ask q a>>=print.jug.sum
setting=hSetBuffering stdin NoBuffering>>hSetBuffering stdout NoBuffering
ask x y =print x>>getChar>>=return.fromEnum.(==y)
jug n |n >= 8 = "You win!"
 |otherwise="You lose"
q = ["Q1","Q2","Q3","Q4","Q5","Q6","Q7","Q8","Q9","Q10"]
a = "1234123412"

{-
遅延評価とIO - あどけない話
https://kazu-yamamoto.hatenablog.jp/entry/20090603/1244010880
monads - Is Haskell's mapM not lazy? - Stack Overflow
https://stackoverflow.com/questions/3270255/is-haskells-mapm-not-lazy
正格評価と遅延評価（モナド編） - Qiita
https://qiita.com/ruicc/items/553119c6586884c785a0
お気楽 Haskell プログラミング入門 Applicative
http://www.nct9.ne.jp/m_hiroi/func/haskell14.html
-}
