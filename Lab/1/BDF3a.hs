module BDF3a where

import ForSyDe.Shallow

-- SWITCH

switch (s_in, c) = (s_out_t, s_out_f) where
    (s_out_t, s_out_f) = k_1 switch_c s_in
    switch_c = d_1 c

k_1 = kernel12SADF

d_1 = detector11SADF consume_rate next_state 
                     select_scenario initial_state where
    consume_rate = 1
    next_state _ [True] = 1
    next_state _ [False] = 0
    switch_scenario_t = (1, (1, 0), \[x] -> ([x], []))
    switch_scenario_f = (1, (0, 1), \[x] -> ([], [x]))
    select_scenario 0 = (1, [switch_scenario_f])
    select_scenario 1 = (1, [switch_scenario_t])
    initial_state = 0

switch_test = (signal [1, 2, 3, 4], signal [True, True, False, True])

-- SELECT

select (s_in_t, s_in_f, c) = s_out where
    s_out = k_2 select_c s_in_t s_in_f
    select_c = d_2 c

k_2 = kernel21SADF

d_2 = detector11SADF consume_rate next_state 
                     select_scenario initial_state where
    consume_rate = 1
    next_state _ [True] = 1
    next_state _ [False] = 0
    select_scenario_t = ((1, 1), 1, \[x] [y] -> [x])
    select_scenario_f = ((1, 1), 1, \[x] [y] -> [y])
    select_scenario 0 = (1, [select_scenario_f])
    select_scenario 1 = (1, [select_scenario_t])
    initial_state = 0

select_test = (signal [1, 2, 3, 4], signal [5, 6, 7, 8], signal [False, True, False, True])
