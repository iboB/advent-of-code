Dirs = [-1, 1i, 1, -1i]

Cell = Struct.new(:h, :r)
valleys = []
peaks = []

MAP = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    pos = x+y.i
    c = Cell.new(c.to_i, Set[])
    valleys << pos if c.h == 0
    peaks << c if c.h == 9
    [pos, c]
  }
}.to_h

def dfs(start_pos, cur_pos)
  cur = MAP[cur_pos]
  Dirs.each { |dir|
    pos = cur_pos + dir
    c = MAP[pos]
    next if !c
    next if c.h != cur.h + 1
    next if c.r === start_pos
    c.r << start_pos
    dfs start_pos, pos
  }
end

valleys.each { dfs _1, _1 }
p peaks.sum { _1.r.size }
