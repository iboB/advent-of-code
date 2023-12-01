gifts[n_Integer] := Block[{l},
    l = Divisors[n];
    l = #[[2]]& /@ TakeWhile[Transpose[{l, Reverse@l}], #[[1]] <= 50 &];
    (Plus @@ l) * 11
]

(* Print[gifts[665280]] *)
n = 29000000
For[i = 1, gifts[i] < n, ++i];
Print[i]
