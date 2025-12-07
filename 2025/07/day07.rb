cur, *grid = File.readlines(?i).map { |l| l.strip.chars.map { _1 == ?. ? 0 : 1 } }

nsplits = 0
last = grid.inject(cur) { |cur, row|
  cur.zip(row).each.with_index { |(c, r), i|
    next if c * r == 0
    nsplits += 1

    n = cur[i]
    cur[i - 1] += n
    cur[i + 1] += n
    cur[i] = 0
  }
  cur
}

p nsplits
p last.sum
