input = File.readlines(?i).map { |l|
  c, *b, _ = l.split
  [c[1...-1].chars.map { _1 == ?# }, b.map { _1.scan(/\d+/).map(&:to_i) }]
}

# bfs
def solve_a(target, buts)
  cur = [[false] * target.size]
  (1..).each { |step|
    cur = cur.flat_map { |state|
      buts.map { |b|
        state.dup.tap { |m|
          b.each { m[_1] = !m[_1] }
          return step if m == target
        }
      }
    }.uniq
  }
end

p input.sum { solve_a *_1 }
