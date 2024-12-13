input = ToExpression /@ StringCases[#, RegularExpression["\\d+"]]& /@ ReadList["input.txt", String]

solve[input_, ta_] := Plus @@
    (3q1 + q2 /. #[[1]]& /@ Select[# != {} &] @
        (Solve[q1*#1 + q2*#2 == #3 + Table[ta, 2], {q1, q2}, Integers]& @@ # & /@ Partition[input, 3]))

Print@solve[input, 0]
Print@solve[input, 10000000000000]
