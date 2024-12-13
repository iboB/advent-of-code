p File.read('input.txt').strip.split("\n\n").map { |t|
  t.lines.map {
    x, y = _1.scan(/\d+/).map(&:to_i)
    x + y.i
  }
}.map { |a, b, target|
  max = (target / b).real.to_i
  max.downto(0).map { [_1, (target - b * _1) / a] }
    .find { _2.imag == 0 && _2.real.denominator == 1 }

}.compact.sum { _1  + 3 * _2.real }

