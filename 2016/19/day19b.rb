# used:
#
# p 1.upto(10).map { |n|
#   ar = (1..n).to_a
#   while ar.length != 1
#     hl = ar.length/2
#     ar = ar[1...hl] + ar[hl+1..] + [ar[0]]
#     p ar.length if ar.length % 1000 == 0
#   end
#   ar[0]
# }
#
# to find n-cowboy shootout problem from oeis: https://oeis.org/A334473

def n_cowboy(n)
  hp3 = 1
  hp3 *= 3 while hp3 <= n
  hp3 /= 3
  return hp3 if hp3 == n
  mod = n % hp3
  return mod if n < 2 * hp3
  hp3 + 2 * mod
end

p n_cowboy(3004953)
