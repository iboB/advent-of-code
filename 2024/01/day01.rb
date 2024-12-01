a, b = File.readlines('input.txt').map { |l|
  l.split.map(&:to_i)
}.transpose

# a
p a.sort.zip(b.sort).map { (_1 - _2).abs }.sum

# b
p a.map { b.count(_1) * _1 }.sum
