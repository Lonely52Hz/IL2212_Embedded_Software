module SADF2 where

import ForSyDe.Shallow

system s_in = (s_out1, s_out2) where
    (s_out1, s_out2) = k c s_in
    c = d s_in

k = kernel12SADF

d = detector11SADF consume_rate next_state 
                   select_scenario initial_state where
    consume_rate = 1
    next_state 0 _ = 1
    next_state 1 _ = 0
    k_scenario_0 = (1, (1, 0), \[x] -> ([x], []))
    k_scenario_1 = (1, (0, 1), \[x] -> ([], [-x]))
    select_scenario 0 = (1, [k_scenario_0])
    select_scenario 1 = (1, [k_scenario_1])
    initial_state = 1

test_s = signal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]