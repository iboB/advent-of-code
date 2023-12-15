p File.read('input.txt').strip.split(?,).map { |str|
  [str.scan(/[a-z]+/).first.chars.inject(0) { ((_1 + _2.ord) * 17) % 256 }, str.tr(?-, ?=)]
}.each_with_object(Hash.new { |h, k| h[k] = [] }) { |b, h|
  h[b[0]] << b[1]
}.transform_values { |v|
  v.map { _1.split('=') }.each_with_object({}) { |(l, f), h|
    f ? h[l] = f.to_i : h.delete(l)
  }.values
}.map { |ib, lenses|
  lenses.map.with_index { |f, il|
    (1 + ib) * (1 + il) * f
  }.sum
}.sum
