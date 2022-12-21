ToExpression /@ StringReplace[":" -> ":="] /@ ReadList["input.txt", String]
Print@root
