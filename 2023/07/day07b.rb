C2A = Hash.new { |h, k| k == ?J ? '1' : k }.merge %w(T Q K A).zip(?A..).to_h

p File.readlines('input.txt').map { |l|
  hand, bid = l.strip.split
  hand = hand.chars.map { C2A[_1] }
  th = hand.tally

  if th.length > 1
    j = th['1']
    th.delete('1')
    th = th.values.sort.reverse
    th[0] += j if j
  else
    # JJJJJ
    th = [5]
  end

  [th.join, hand.join, bid.to_i]
}.sort.map.with_index { |c, i|
  c[-1] * (i + 1)
}.sum
