lines = File.readlines('input.txt').map(&:strip)
moves = lines[0].chars.map { _1 == ?L ? 0 : 1}

nodes = lines[2..].map {
  a, b, c = _1.scan(/[0-9A-Z]+/)
  [a, [b, c]]
}.to_h

p nodes.keys.select { _1[-1] == ?A }.map { |start|
  cur = nodes[start]
  1 + (0..).find { |i|
    nn = cur[moves[i % moves.length]]
    cur = nodes[nn]
    nn[-1] == ?Z
  }
}.inject { _1.lcm(_2) }
