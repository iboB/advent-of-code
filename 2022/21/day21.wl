(* Initially I didn't know how to properly extract the values, but thanks to
Daniel Huber here: https://mathematica.stackexchange.com/questions/277602/how-to-replace-in-an-evaluatable-named-expression
I can now have day21 in a concise single program *)

ToExpression /@ StringReplace[":" -> ":="] /@ ReadList["input.txt", String]

(* Part 1 *)
Print@root

(* Part 2 *)
humn = x
eq = ReleaseHold[Extract[OwnValues@root, {1, 2}, Hold] /. Plus -> Equal]
Print@Solve[eq, x]
