import Data.List
import Data.Complex
import System.Random
import Data.Ord

import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo

-- https://hackage.haskell.org/package/Chart-cairo-1.8/docs/Graphics-Rendering-Chart-Backend-Cairo.html
--  凸包を求めるアルゴリズム（ギフト包装法）
-- https://qiita.com/lotz/items/de76350e3fffeae51f76


type Poi = Complex Float

angle :: Poi -> Poi -> Poi -> Float
angle p0 v p1 = phase $ (p1-p0)/(signum v)

type Line = [Poi]

giftWrapping :: [Poi] -> Line
giftWrapping ps | length ps < 3 = ps
giftWrapping ps =
  let p0 = minimumBy (comparing realPart) ps
      vx = (1.0:+ 0.0)
      ps' = ps \\ [p0]
      p1 = minimumBy (comparing (angle p0 vx)) $ ps'
      ps2 = ps' \\ [p1]
   in go [p1, p0] (p1:p0:ps2) p0
  where
    go :: [Poi] -> [Poi] -> Poi -> [Poi]
    go history@(p2:p1:rest) ps@(px2:px1:restx) goal=
      let v = p2-p1
          pn' = minimumBy (comparing (angle p2 v)) $ restx
          ps3 = restx \\ [pn']
       in if pn' == goal
             then pn' : history
             else go (pn' : history) (pn':px2:px1:ps3) goal

generate :: Int -> [Poi]
generate n = zipWith (:+) xs ys
    where 
     randomSeq :: Int -> Int -> [Float] 
     randomSeq seed m=take m.randomRs (0.0,1.0) $mkStdGen seed
     xs=randomSeq 1234 n
     ys=randomSeq 2011 n

im :: [Poi] -> Line ->  EC (Layout Float Float) ()
im ps ln = do
  setColors [opaque blue, opaque red]
  plot (line "convex hull" [(map f ln)])
  plot (points "Pois" (map f ps))
  where 
   f::Poi->(Float, Float)
   f (a:+b)= (a,b)

main :: IO ()
main = 
  let ps = generate 30
      ln = giftWrapping ps
      def0 =  FileOptions (800,600) PNG
  in
      print ln >> (toFile def0 "gift-wrapping.png" $ im ps ln)
