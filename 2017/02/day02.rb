input = File.readlines('input.txt').map { _1.strip.split.map(&:to_i) }
p input.sum { |l| l.minmax.then { _2 - _1 } }
p input.sum { |l| l.permutation(2).find { _1 % _2 == 0 }.then { _1/_2 } }
