DTOI = %w(zero one two three four five six seven eight nine).each.with_index.to_h.merge (0..9).map { [_1.to_s, _1] }.to_h
RE = /(?=(#{DTOI.keys.join('|')}))/

p File.readlines('input.txt').map { |l|
  s = l.strip.scan(RE)
  DTOI[s[0][0]] * 10 + DTOI[s[-1][0]]
}.sum
