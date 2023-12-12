(*
initial solution of a which finds all possible divisions into ones separated by
zeores and filters out the ones that match the pattern
too slow for b
*)
tolist[str_] := ToExpression@StringJoin@{"{", str, "}"}
tp["."] = 0; tp["#"] = 1; tp["?"] = _
topat[str_] := tp /@ Characters@str
toq[p_, l_] := {topat@p, tolist@l}

solve[pat_, list_] := Block[{
    rem = Length@pat - Plus@@list + 2,
    ones = Table[1, #]& /@ list
    },
    (MatchQ@pat)@Take[#, {2, Length@pat+1}]&
        /@ (Flatten@Riffle[Table[0, #]& /@ #, ones]&
            /@ Flatten[Permutations /@ IntegerPartitions[rem, {Length@list+1}], 1])
                // Count@True
]

Print[Plus @@ solve @@@ toq @@@ StringSplit /@ ReadList["input.txt", String]]


