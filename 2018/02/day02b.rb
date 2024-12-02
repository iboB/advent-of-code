def same(a, b) = a.zip(b).select { _1 == _2 }.map(&:first)

p File.readlines('input.txt').map { _1.strip.chars }.combination(2).select {
  same(_1, _2).size == _1.size - 1
}.first.yield_self {
  same(_1, _2).join
}
