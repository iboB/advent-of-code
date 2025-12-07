cur, *grid = File.readlines(?i).map { |l| l.strip.chars.map { _1 == ?. ? 0 : 1 } }

nsplits = 0
last = grid.inject(cur) { |cur, row|
  row.each_with_index { |r, i|
    c = cur[i]
    next if c * r == 0
    nsplits += 1
    cur[i - 1] += c
    cur[i + 1] += c
    cur[i] = 0
  }
  cur
}

p nsplits
p last.sum
