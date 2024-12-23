edges = File.readlines('input.txt').map { |l| l.strip.split(?-) }.then { _1 + _1.map(&:reverse) }.to_set

p edges.flat_map { |a, b|
  edges.select { _1 == b && _2 != a }.map { [a, b, _2].sort if edges === [_2, a] }.compact
}.to_set.select { |t|
  t.any? { _1[0] == 't' }
}.size
