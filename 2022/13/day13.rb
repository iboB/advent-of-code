def interleave(a, b)
  if a.length >= b.length
    a.zip(b).to_a
  else
    b.zip(a).map(&:reverse)
  end
end

def cmp(a, b)
  return -1 if !a
  return 1 if !b
  if Integer === a
    if Integer === b
      return a <=> b
    else
      a = [a]
      l = cmp(a, b)
      return l if l != 0
    end
  else
    if Integer === b
      b = [b]
      l = cmp(a, b)
      return l if l != 0
    else
      interleave(a, b).each { |aa, bb|
        l = cmp(aa, bb)
        return l if l != 0
      }
    end
  end
  return 0
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

