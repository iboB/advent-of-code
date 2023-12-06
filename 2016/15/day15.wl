norm[i_, slots_, z_, pos_] := {slots, slots - (pos + i) ~ Mod ~ slots}

solve[input_] := ChineseRemainder @@ Reverse@Transpose@input

input = norm @@ #& /@
    ToExpression /@ (StringCases[#, RegularExpression["\\d+"]]& /@ ReadList["input.txt", String])

(*a*)
Print@solve@input

(*b*)
AppendTo[input, norm[Length@input + 1, 11, 0, 0]]
Print@solve@input
