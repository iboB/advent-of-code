input = StringSplit /@ ReadList["i", String]

(*
build minimize expression for each line in input

Example:
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    Leads to:

    Minimize[
        x1 + x2 + x3 + x4 + x5 + x6,
        3 == x5+x6 && 5 == x2+x6 && 4 == x3+x4+x5 && 7 == x1+x2+x4
            && x1 >= 0 && x2 >= 0 && x3 >= 0 && x4 >= 0 && x5 >= 0 && x6 >= 0,
        {x1, x2, x3, x4, x5, x6},
        Integers
    ]
*)
makex[i_] := ToExpression["x" <> ToString[i]]
buildBut[b_, {i_}] := {# + 1, makex@i} & /@ b;
solve[{c_, b__, j_}] := Module[{},
    jolts = ToExpression[j];
    vars = Array[makex, Length@{b}];
    vec = GroupBy[
        MapIndexed[buildBut,
            ToExpression /@ StringCases[#, RegularExpression["\\d+"]]& /@ {b}] ~ Flatten ~ 1,
        First -> Last
    ];
    First@Minimize[
        Plus @@ vars,
        And @@ KeyValueMap[jolts[[#1]] == Plus@@#2&, vec] && And @@ Thread[vars >= 0],
        vars,
        Integers
    ]
]

Print[Total[solve /@ input] // Timing]
