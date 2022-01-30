module BDF3b where

import ForSyDe.Shallow

system (a, b) = e where
    e = k2 c2 s2 s4
    s2 = c s1
    s4 = d s3
    (s1, s3) = k1 c1 a
    c1 = detector1 b
    c2 = detector2 b

k2 = kernel21SADF

k1 = kernel12SADF

-- identity function

c = actor11SDF 1 1 f1 where
    f1 [x] = [x]

-- negation function

d = actor11SDF 1 1 f2 where
    f2 [x] = [-x]

detector1 = detector11SADF consume_rate next_state 
                           select_scenario initial_state where
    consume_rate = 1
    next_state _ [True] = 1
    next_state _ [False] = 0
    switch_scenario_t = (1, (1, 1), \[x] -> ([x], [-1]))
    switch_scenario_f = (1, (1, 1), \[x] -> ([-1], [x]))
    select_scenario 0 = (1, [switch_scenario_f])
    select_scenario 1 = (1, [switch_scenario_t])
    initial_state = 0

detector2 = detector11SADF consume_rate next_state 
                           select_scenario initial_state where
    consume_rate = 1
    next_state _ [True] = 1
    next_state _ [False] = 0
    select_scenario_t = ((1, 1), 1, \[x] [y] -> [x])
    select_scenario_f = ((1, 1), 1, \[x] [y] -> [y])
    select_scenario 0 = (1, [select_scenario_f])
    select_scenario 1 = (1, [select_scenario_t])
    initial_state = 0

test_s = (signal [1, 2, 3, 4], signal [True, False, True, False])
