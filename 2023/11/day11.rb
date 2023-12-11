points = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip!.chars.map.with_index { |c, x|
    [x, y] if c == ?#
  }.compact
}

empty = points.transpose.map { (0.._1.max).to_a - _1.tally.keys }

puts [2, 1_000_000].map { |expand|
  add = expand - 1

  points.map { |pt|
    pt.zip(empty).map { |c, e| c + add * e.count { _1 < c } }
  }.combination(2).map { |a, b|
    a.zip(b).map { (_1 - _2).abs }.sum
  }.sum
}
