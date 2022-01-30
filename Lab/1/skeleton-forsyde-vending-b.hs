module VendingMachine where

import ForSyDe.Shallow

data Coin = C5 | C10 deriving (Show, Eq, Ord)
data Bottle = B deriving (Show, Eq, Ord)
data Return = R deriving (Show, Eq, Ord)

type Coin_Event = AbstExt Coin
type Bottle_Event = AbstExt Bottle
type Return_Event = AbstExt Return

vendingMachine :: Signal Coin_Event -- Signal of Coins
               -> Signal (Bottle_Event, Return_Event) -- Signal of (Bottle, Return)

-- Your code
vendingMachine s_in = s_out where
    s_out = p_output s_nextstate
    s_nextstate = p_nextstate s_state s_in
    s_state = p_state s_nextstate

-- selection of process constructors
p_nextstate = zipWithSY nextstate
p_state = delaySY 0
p_output = mapSY output

-- specification of leaf functions

-- scenario 0: value = 0, bottle = false, return = false (0, 0 + 0, 10 + 0)
-- scenario 1: value = 0, bottle = true, return = false (10, 5 + 5, 0 + 10, 10 + 10)
-- scenario 2: value = 0, bottle = true, return = true (5 + 10)
-- scenario 3: value = 5, bottle = false, return = false (0 + 5, 5, 5 + 0, 10 + 5)

nextstate 0 (Prst C5) = 3
nextstate 0 (Prst C10) = 1
nextstate 0 Abst = 0
nextstate 1 (Prst C5) = 3
nextstate 1 (Prst C10) = 1
nextstate 1 Abst = 0
nextstate 2 (Prst C5) = 3
nextstate 2 (Prst C10) = 1
nextstate 2 Abst = 0
nextstate 3 (Prst C5) = 1
nextstate 3 (Prst C10) = 2
nextstate 3 Abst = 3

output 0 = (Abst, Abst)
output 1 = (Prst B, Abst)
output 2 = (Prst B, Prst R)
output 3 = (Abst, Abst)


s_coin = signal [Prst C10, Prst C5, Prst C5, Prst C5, Prst C10, Abst]

