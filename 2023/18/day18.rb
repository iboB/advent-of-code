Dirs = {?R => 1, ?L => -1, ?D => 1i, ?U => -1i}

# assume positive winding
Shifts = {?R => 0, ?U => 0, ?D => 1, ?L => 1i}

def solve(input)
  input << input[0]

  pos = 0
  edge = input.each_cons(2).map { |a, b|
    pos += Dirs[a[0]] * a[1]
    pos + Shifts[a[0]] + Shifts[b[0]]
  }

  ([edge[-1]] + edge).each_cons(2).map { |a, b|
    (a.conj * b).imag
  }.sum / 2
end

# a
p solve File.readlines('input.txt').map { |l|
  dir, n = l.strip.split
  [dir, n.to_i]
}

# b
p solve File.readlines('input.txt').map { |l|
  col = l.strip.split[-1][2..-2]
  ["RDLU"[col[-1].to_i], col[..-2].to_i(16)]
}
