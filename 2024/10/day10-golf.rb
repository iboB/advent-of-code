map = File.readlines('input.txt').flat_map.with_index { |l, y| l.strip.chars.map.with_index { [_2+y.i, _1.to_i] }}.to_h
puts map.select { _2 == 0 }.map { |s, _|
  (1..9).inject({s => 1}) { |l, h|
    l.map { |p, n|
      [p+1,p-1,p+1i,p-1i].map { [_1, n] if map[_1] == h }.compact.to_h
    }.inject { |a, b| a.merge(b) { _2 + _3 } }
  }.then { |l| [l.length, l.sum { _2 }] }
}.transpose.map(&:sum)
