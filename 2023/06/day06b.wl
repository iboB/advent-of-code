(* just a cool solution to b to refresh my wl skills *)
{t, d} = StringJoin[StringCases[#, RegularExpression["\\d+"]]]& /@ ReadList["input.txt", String] // ToExpression
sol = Reduce[x(t-x) > d]
Print[Subtract @@ Ceiling /@ {Last@sol, First@sol}]

