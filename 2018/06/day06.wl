(* Print[
    Reduce[Abs[1 - x] + Abs[1 - y] < Abs[3 - x] + Abs[4 - y], {x, y}, Integers]
] *)

pts = {{1, 1}, {1, 6}, {8, 3}, (*{3, 4},*) {5, 5}, {8, 9}};

ins = Abs[3 - x] + Abs[4 - y] < Abs[#[[1]] - x] + Abs[#[[2]] - y] & /@ pts

Print@Reduce[ins, {x, y}, Integers]



