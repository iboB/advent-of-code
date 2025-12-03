# solution for a, created first

input = File.readlines(?i).map { _1.strip.chars.map(&:to_i) }

p input.map { |seq|
  seq.each_with_index.max.yield_self { |n, i|
    [[seq[...i].max, n], [n, seq[(i + 1)..].max]].map(&:join).map(&:to_i).max
  }
}.sum
