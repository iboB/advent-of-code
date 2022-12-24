require 'matrix'

DC = {'>' => Vector[1, 0], '<' => Vector[-1, 0], 'v' => Vector[0, 1], '^' => Vector[0, -1]}

w = 0
h = 0
Bliz = File.readlines('input.txt')[1..-2].map.with_index { |l, y|
  h = y + 1
  l.strip.split(//)[1..-2].map.with_index { |c, x|
    w = x + 1
    [Vector[x, y], DC[c]] if c != ?.
  }.compact
}.flatten(1)

W = w
H = h

def move
  Bliz.each do |pos, dir|
    pos[0..] = pos + dir
    pos[0] %= W
    pos[1] %= H
  end
end

def make_grid
  grid = H.times.map { [1] * W }
  Bliz.each do |pos, _|
    grid[pos[1]][pos[0]] = nil
  end
  grid
end

Grids = [make_grid]

@cur_move = 0
def gen()
  @cur_move += 1
  move
  Grids << [make_grid]
end

bfs = []
while true do
end



