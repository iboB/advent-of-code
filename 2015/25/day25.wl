(* row 3010, column 3019. *)
y = 3010
x = 3019
start = 20151125
mul = 252533
mod = 33554393

Print[Mod[start * PowerMod[mul, Binomial[y, 2] + (x - 1)(2y + x)/2, mod], mod]]
