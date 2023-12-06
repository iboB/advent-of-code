p File.readlines('input.txt').map { |l|
  l.strip.scan(/\d+/).map(&:to_i)
}.transpose.map { |time, record|
  0.upto(time).map { _1 * (time - _1) }.select { _1 > record }.length
}.inject(:*)
