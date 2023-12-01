p File.readlines('input.txt').map { |l|
  d = l.strip.scan(/\d/)
  d[0] + d[-1]
}.map(&:to_i).sum
