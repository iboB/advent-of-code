input = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    [x + y * 1i, c]
  }
}.to_h
input.default = ?z

# a
Dirs = [
  -1 - 1i, -1 + 0i, -1 + 1i,
   0 - 1i,           0 + 1i,
   1 - 1i,  1 + 0i,  1 + 1i,
]
p input.map { |pos, str|
  next 0 if str != ?X
  Dirs.map { |d|
    input.values_at(*4.times.map { pos + d * _1 }).join
  }.count('XMAS')
}.sum

# b
p input.count { |pos, str|
  next false if str != ?A
  d1 = input.values_at(pos - 1 - 1i, pos + 1 + 1i).sort.join
  d2 = input.values_at(pos - 1 + 1i, pos + 1 - 1i).sort.join
  d1 == 'MS' && d2 == 'MS'
}
