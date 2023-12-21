(* output  of day21.rb *)
data = {3799, 34047, 94475}
f[x_] = Fit[data, {1, x, x^2}, x] /. n_Real -> Round[n]
Print@f[26501365 ~ Quotient ~ 131 + 1]
