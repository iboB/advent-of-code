# [a, b]
p File.readlines('input.txt').map(&:strip).map {
  [_1.length - eval(_1).length, _1.inspect.length - _1.length]
}.transpose.map(&:sum)
