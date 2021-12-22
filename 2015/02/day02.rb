input = File.readlines('input.txt').map { |l|
  l.split('x').map(&:to_i)
}

# a
p input.map { |xyz|
    xyz.combination(2).map { 2 * _1 * _2 }.sum + xyz.sort[0..1].inject(&:*)
}.sum

# b
p input.map { |xyz|
  xyz.sort[0..1].sum * 2 + xyz.inject(&:*)
}.sum
