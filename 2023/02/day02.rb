C0 = %w(red green blue).zip([0] * 3).to_h
input = File.readlines('input.txt').map { |l|
  id, draws = l.split(':')
  draws.split(';').map { |d|
    hash = d.scan(/red|green|blue/).zip(d.scan(/\d+/).map(&:to_i)).to_h
    hash = C0.merge(hash)
    hash.to_a.sort_by(&:first).reverse.map(&:last)
  }
}

# a
Q = (12..14).to_a
p input.map.with_index { |draws, i|
  draws.all? { |d| d.zip(Q).all? { _1 <= _2 } } && i + 1
}.select(&:itself).sum

# b
p input.map { |draws|
  draws.inject { |d0, d| d0.zip(d).map(&:max) }.inject { _1 * _2 }
}.sum
