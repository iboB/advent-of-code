C2A = Hash.new { _2 }.merge %w(T J Q K A).zip(?A..).to_h

p File.readlines('input.txt').map { |l|
  hand, bid = l.strip.split
  hand = hand.chars.map { C2A[_1] }
  [hand.tally.values.sort.join.reverse, hand.join, bid.to_i]
}.sort.map.with_index { |c, i|
  c[-1] * (i + 1)
}.sum
