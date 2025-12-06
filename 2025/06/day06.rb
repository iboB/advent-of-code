lines = File.readlines(?i)

# a
p lines.map(&:split).transpose.sum { eval _1[...-1].join(_1[-1]) }

# b
ops = lines[-1].scan(/\S\s+/).map(&:chop)

p lines[...-1].map { |line|
  ops.map(&:size).map {
    front, line = line[0..._1], line[_1+1..]
    front.chars
  }
}.transpose.map.with_index {
  eval _1.transpose.map(&:join).join(ops[_2])
}.sum
