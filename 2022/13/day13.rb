def cmp(a, b)
  case [a, b]
  in [nil, _] then -1
  in [_, nil] then 1
  in [Integer, Integer] then a <=> b
  in [Integer, Array] then cmp([a], b)
  in [Array, Integer] then cmp(a, [b])
  else
    if a.length >= b.length
      a.zip(b)
    else
      b.zip(a).map(&:reverse)
    end.each { |aa, bb|
      l = cmp(aa, bb)
      return l if l != 0
    }
    0
  end
end

# a
p File.read('input.txt').strip.split("\n\n").map.with_index { |pack, i|
  a, b = pack.split("\n").map { eval(_1) }
  cmp(a, b) == -1 ? i + 1 : 0
}.sum


# b
diva = [[2]]
divb = [[6]]

sorted = (File.readlines('input.txt').map { |l|
  eval(l)
}.compact + [diva, divb]).sort { |a, b| cmp(a, b) }

p (sorted.index(diva) + 1) * (sorted.index(divb) + 1)

