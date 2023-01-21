module Data.Num.Fib (fib)  where

{-# LANGUAGE Strict #-}
data SM2=SM2 {-# UNPACK #-} !Int {-# UNPACK #-} !Int {-# UNPACK #-} !Int
instance Num SM2 where
    (SM2 a1 b1 c1) * (SM2 a2 b2 c2)=let b=b1*b2 in SM2 (a1*a2+b) (a1*b2+b1*c2) (b+c1*c2)

fromSM2 (SM2 _ b _)=b

fib n=fromSM2 ((SM2 1 1 0)^n)
