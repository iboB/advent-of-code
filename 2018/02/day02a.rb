
p File.readlines('input.txt').map {
  freq = _1.strip.chars.tally.values.uniq
  [freq.include?(2), freq.include?(3)]
}.transpose.map { _1.count(true) }.reduce(:*)
