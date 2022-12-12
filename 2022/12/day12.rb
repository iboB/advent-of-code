require 'matrix'
start_pos = nil
end_pos = nil
Input = File.readlines('input.txt').map.with_index { |l, y|
  l.strip.split(//).map.with_index { |e, x|
    h = if e == ?S
      start_pos = Vector[x, y]
      0
    elsif e == ?E
      end_pos = Vector[x, y]
      25
    else
      e.ord - ?a.ord
    end
    {h: h, best: 1_000_000}
  }
}

H = Input.length
W = Input[0].length

def at(vec)
  Input[vec[1]][vec[0]]
end

Dirs = [Vector[1, 0], Vector[-1, 0], Vector[0, 1], Vector[0, -1]]

# bfs from end to start
at(end_pos)[:best] = 0
bfs = [end_pos]
best_0 = nil
while !bfs.empty? do
  cur_pos = bfs.shift
  cur = at(cur_pos)
  len = cur[:best] + 1
  Dirs.each do |dir|
    next_pos = cur_pos + dir
    next if next_pos[0] < 0 || next_pos[0] >= W || next_pos[1] < 0 || next_pos[1] >= H
    nex = at(next_pos)
    next if nex[:best] <= len
    next if cur[:h] > nex[:h] && cur[:h] - nex[:h] > 1
    best_0 = len if !best_0 && nex[:h] == 0
    if next_pos == start_pos
      p len # a
      p best_0 # b
      exit 0
    end
    nex[:best] = len
    bfs << next_pos
  end
end

