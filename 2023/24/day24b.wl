rays = {Take[#, 3], Take[#, -3]}& /@ ToExpression /@ (StringCases[#, RegularExpression["-?\\d+"]]& /@ Take[ReadList["input.txt", String], 3])
toeq[r_, n_] := Block[{pos, dir, sym = Symbol@ToString@StringForm["t``", n]},
    {pos, dir} = r;
    pos + sym * dir == {x, y, z} + sym * {dx, dy, dz}
]
sol = List@@Reduce[And @@ MapIndexed[toeq[#1, First[#2]]&, rays], {x, y, z}, Integers] /. {a_ == b_ -> b}
Plus@@Take[sol, -3] // Print
