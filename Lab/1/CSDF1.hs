module CSDF1 where

import ForSyDe.Shallow

-- Netlist
system s_in = (s_out1, s_out2) where
    s_out1 = a_2 s_2
    s_out2 = a_3 s_3
    s_2 = d s_1
    (s_1, s_3) = a_1 s_in

-- Process specification
a_1 = actor12SDF 1 (1, 1) f_1 where
    f_1 [x] = ([x], [x])

a_2 = actor11SDF 2 1 f_2 where
    f_2 [x, y] = [y]

a_3 = actor11SDF 2 1 f_3 where
    f_3 [x, y] = [-y]

d s = delaySDF [0] s

test_s = signal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]