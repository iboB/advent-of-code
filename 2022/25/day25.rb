I2S = [?=, ?-, ?0, ?1, ?2].map.with_index { [_2 - 2, _1] }.to_h
S2I = I2S.invert

def i2snafu(i)
  ret = []
  while i != 0
    i, d = i.divmod(5)
    if d < 3
      ret << I2S[d]
    else
      ret << I2S[d - 5]
      i += 1
    end
  end
  ret.reverse.join
end

puts i2snafu File.readlines('input.txt').map { |l|
  l.strip.split(//).reverse.map.with_index { |d, i| 5**i * S2I[d] }.sum
}.sum
