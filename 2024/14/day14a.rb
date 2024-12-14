p File.readlines('input.txt').flat_map { |l|
  l.strip.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a.append([101, 103]).transpose
}.map { (_1 + _2 * 100) % _3 <=> _3 / 2 }.each_slice(2).select { _1 * _2 != 0 }.tally.values.inject(&:*)
