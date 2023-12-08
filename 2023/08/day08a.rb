lines = File.readlines('input.txt').map(&:strip)
moves = lines[0].chars.map { _1 == ?L ? 0 : 1}

nodes = lines[2..].map {
  a, b, c = _1.scan(/[A-Z]+/).map(&:to_sym)
  [a, [b, c]]
}.to_h

cur = nodes[:AAA]
p 1 + (0..).find { |i|
  nn = cur[moves[i % moves.length]]
  cur = nodes[nn]
  nn == :ZZZ
}

