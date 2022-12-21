ToExpression /@ StringReplace[":" -> ":="] /@
    (If[StringStartsQ[#, "root"], StringReplace[#, "+" -> "=="] , #]& /@
        ReadList["input.txt", String])
humn = x
Print@Solve[root, x]
