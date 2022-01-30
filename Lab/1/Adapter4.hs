module Adapter4 where

import ForSyDe.Shallow

system sin = sout where
    (sout, feedback) = k c sin
    t = delay feedback
    c = d t

k = kernel12SADF

delay s = delaySADF [False] s

d = detector11SADF consume_rate next_state 
                   select_scenario initial_state where
    consume_rate = 1
    next_state 0 [True] = 1
    next_state 0 [False] = 0
    next_state 1 [True] = 0
    next_state 1 [False] = 1
    select_scenario_0 = (3, (1, 1), \[x1, x2, x3] -> ([x1 + x2 + x3], [x1 + x2 + x3 > 20]))
    select_scenario_1 = (2, (1, 1), \[x1, x2] -> ([x1 + x2], [x1 + x2 < 10]))
    select_scenario 0 = (1, [select_scenario_0])
    select_scenario 1 = (1, [select_scenario_1])
    initial_state = 0

test_s = signal [4,5,6,8,8,9,9,8,2,4,8,5,2]