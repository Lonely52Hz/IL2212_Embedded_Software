module VendingMachine where

import ForSyDe.Shallow

vendingMachine :: Signal Bool -- Signal of 5 SEK coins
               -> Signal Bool -- Signal of 10 SEK coins
               -> Signal (Bool, Bool) -- Signal of (Bottle, Return)

-- Your code
vendingMachine coin5 coin10 = s_out where
    s_out  = p_output s_nextstate
    s_nextstate =  p_nextstate s_state coin5 coin10
    s_state = p_state s_nextstate

-- selection of process constructors
p_nextstate = zipWith3SY nextstate
p_state = delaySY 0
p_output = mapSY output

-- specification of leaf functions

-- scenario 0: value = 0, bottle = false, return = false (0, 0 + 0, 10 + 0)
-- scenario 1: value = 0, bottle = true, return = false (10, 5 + 5, 0 + 10, 10 + 10)
-- scenario 2: value = 0, bottle = true, return = true (5 + 10)
-- scenario 3: value = 5, bottle = false, return = false (0 + 5, 5, 5 + 0, 10 + 5)

nextstate 0 True False = 3
nextstate 0 False True = 1
nextstate 0 False False = 0
nextstate 1 True False = 3
nextstate 1 False True = 1
nextstate 1 False False = 0
nextstate 2 True False = 3
nextstate 2 False True = 1
nextstate 2 False False = 0
nextstate 3 True False = 1
nextstate 3 False True = 2
nextstate 3 False False = 3

output 0 = (False, False)
output 1 = (True, False)
output 2 = (True, True)
output 3 = (False, False)


s_coin5 =  signal [False, True, True, True, False, False]
s_coin10 = signal [True, False, False, False, True, False]
