start = finish = nil

walls = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    pos = x + y.i
    start = pos if c == ?S
    finish = pos if c == ?E
    pos if c == ?#
  }.compact
}.to_set

vis = Hash.new 10**10
bfs = [[start, 1, 0]]

until bfs.empty?
  pos, dir, pts = bfs.shift
  [[1, 1], [1i, 1001], [-1i, 1001]].each { |d, pen|
    ndir = dir * d
    npos = pos + ndir
    next if walls === npos
    npts = pts + pen
    next if vis[npos] <= npts
    vis[npos] = npts
    bfs << [npos, ndir, npts]
  }
end

p vis[finish]

