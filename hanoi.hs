{-# LANGUAGE StrictData #-}
{-# OPTIONS_GHC -Wall #-}

import Data.Bits
import Data.Int
import Control.Monad(mapM_,forM_,(<=<),when)
import Data.Vector.Mutable(IOVector,replicate,unsafeWrite,unsafeRead)

newtype Pegs=Pegs (IOVector [Int])
printP::Pegs->IO()
printP (Pegs a)=mapM_ (print.init<=<unsafeRead a) [0,1,2]

(<<<)::Int64->Int->Int64
(<<<)=unsafeShiftL
infixl 8 <<<

hanoi::Int->IO ()
hanoi n|n>=64=putStrLn "the End of the World"
       |n<=0=putStrLn "error"
       |otherwise=Data.Vector.Mutable.replicate 3 [n]>>= \a ->
    let p = Pegs a
    in unsafeWrite a 0 [0..n]>>printP p>>forM_ [1..(1 <<< n - 1::Int64)] (m (n .&.1) p)

m::Int->Pegs->Int64->IO ()
m n p = \x ->let
    b=countTrailingZeros x
    y=x `shiftR` (b+1)
    n0=(b.&.1 `xor` n)
    z=y+1
    y0=y <<< n0
    z0=z <<< n0
    in do
        moveP p (fromEnum (y0 `mod` 3)) (fromEnum (z0 `mod` 3))
        putStr "Turn:"
        print x
        printP p

moveP::Pegs->Int->Int->IO ()
moveP (Pegs a) d s =do
    (x:xs)<-unsafeRead a d
    (y:ys)<-unsafeRead a s
    when (x>=y) $ fail "error"
    unsafeWrite a d xs
    unsafeWrite a s (x:y:ys)

main::IO ()
main=hanoi 7
