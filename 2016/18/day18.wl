(* incomplete... don't know enough about CellularAutomaton to make it work *)
start = Boole[# == "^"]& /@ Characters@StringTrim@ReadString@"input.txt"
CellularAutomaton[{{0,_,1}->1,{1,_,0}->1,{_,_,_}->0}, {start, 0}, 10] // Print
