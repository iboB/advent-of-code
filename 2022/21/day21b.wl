ToExpression /@ StringReplace[":" -> ":="] /@
    (If[StringStartsQ[#, "root"], StringReplace[#, RegularExpression["\\+|\\-|\\*|\\/"] -> "=="] , #]& /@
        ReadList["input.txt", String])
humn = x
Print@Solve[root, x]
