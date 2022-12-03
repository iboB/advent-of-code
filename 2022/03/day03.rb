input = File.readlines('input.txt').map { |s|
  s.strip!.bytes.map { |b|
    1 + (b <= ?Z.ord ? b - ?A.ord + 26 : b - ?a.ord)
  }
}

# a
p input.map { |bag|
  hl = bag.length / 2
  (bag[0...hl] & bag[hl..]).sum
}.sum

# b
p input.each_slice(3).map { |a, b, c|
  (a & b & c).sum
}.sum
