(*
    this eval hack only works with the example input
    sadly the real input was too much for wolfram engine :(
*)

toif[str_String] := Block[{cnd = StringSplit[str, ":"]},
    If[Length@cnd == 1,
        {StringJoin[cnd[[1]], "[x,m,a,s]"], ";"},
        {StringJoin["If[", cnd[[1]], ", ", cnd[[2]], "[x,m,a,s], "], "]"}
    ]
]

tofunc[str_String] := Block[{fun, body},
    {{fun, body}} = StringCases[str, RegularExpression["([a-z]+)\{(.+)\}"] :> {"$1", "$2"}];
    StringJoin@Flatten[{fun, "[x_,m_,a_,s_]:=", Transpose[toif /@ StringSplit[body, ","]]}]
]

A[x_,m_,a_,s_]:=True;
R[x_,m_,a_,s_]:=False;

ToExpression /@ tofunc /@ TakeWhile[ReadList["input.txt", String], StringPart[#, 1] != "{"&]

syms = {x,m,a,s}

i2r[min_, Less, _, Less, max_] := max - min - 1;
i2r[min_, Less, _, LessEqual, max_] := max - min;
i2r[min_, LessEqual, _, Less, max_] := max - min;
i2r[min_, LessEqual, _, LessEqual, max_] := max - min + 1;

Reduce[in @@ syms && And @@ ((0 < # < 4001)& /@ syms), syms] /. {And -> Times, Or -> Plus, Inequality -> i2r} // Print
