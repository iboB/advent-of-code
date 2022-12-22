require 'matrix'
world, path = File.read('input.txt').split("\n\n")

path = path.strip.split(/(?=[R|L])/).map { _1.split(/(?<=[R|L])/) }.flatten.map { |i|
  next i if i == ?R || i == ?L
  i.to_i
}

world = world.lines.map { _1.gsub("\n", '').split(//) }
h = world.size
w = world.map(&:size).max
world.each { _1.fill(' ', _1.size...w) } # pad
start_pos = Vector[world[0].index('.'), 0]

class Cell
  def initialize(c, w)
    @pos = c
    @wall = w
    @nbrs = [nil]*4
  end
  attr :pos, :nbrs
  def wall?
    @wall
  end
  def inspect
    "#{@wall ? '#' : '.'}"
  end
end

Right = 0
Down = 1
Left = 2
Up = 3

# transform each char to cell
@world_hash = {}
world = world.map.with_index { |row, y|
  row.map.with_index { |char, x|
    next nil if char == ' '
    pos = Vector[x, y]
    cell = Cell.new pos, char == ?#
    @world_hash[pos] = cell
  }
}

Dirs = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]]

# set known cell neighbors
@world_hash.values.each do |cell|
  pos = cell.pos
  4.times do |dir|
    cell.nbrs[dir] = @world_hash[pos + Dirs[dir]]
  end
end

Cub = w.gcd(h) # cube side

def cells_in(range)
  pos = range[0]
  dir = Dirs[range[1]]
  ret = []
  Cub.times {
    ret << @world_hash[pos]
    pos += dir
  }
  ret
end

def fuse(a, adir, b, bdir)
  cells_in(a).zip(cells_in(b)).each do |ac, bc|
    ac.nbrs[adir] = bc
    bc.nbrs[bdir] = ac
  end
end

# i don't have the time (or motivation) to invest in a folding algorithm here,
# so, I'll just hardcode the fold
if Cub == 4
  # example
  #     aa
  #     aa
  # bbccdd
  # bbccdd
  #     eeff
  #     eeff
  fuse([Vector[2*Cub,0], Down],       Left,   [Vector[Cub,Cub],   Right],     Up)
  fuse([Vector[2*Cub,0], Right],      Up,     [Vector[Cub-1,Cub], Left],      Up)
  fuse([Vector[3*Cub-1,0], Down],     Right,  [Vector[4*Cub-1,3*Cub-1], Up],  Right)
  fuse([Vector[0, Cub], Down],        Left,   [Vector[4*Cub-1,3*Cub-1], Left],Down)
  fuse([Vector[0, 2*Cub-1], Right],   Down,   [Vector[3*Cub-1,3*Cub-1], Left],Down)
  fuse([Vector[Cub, 2*Cub-1], Right], Down,   [Vector[2*Cub, 3*Cub-1], Up],   Left)
  fuse([Vector[3*Cub, 2*Cub], Right], Up,     [Vector[3*Cub-1, 2*Cub-1], Up], Right)
else
  # puzzle input:
  #   aabb
  #   aabb
  #   cc
  #   cc
  # ddee
  # ddee
  # ff
  # ff
  fuse([Vector[Cub, 0], Down], Left, [Vector[0,3*Cub-1], Up], Left)
  fuse([Vector[Cub, 0], Right], Up, [Vector[0,3*Cub], Down], Left)
  fuse([Vector[2*Cub, 0], Right], Up, [Vector[0,4*Cub-1], Right], Down)
  fuse([Vector[3*Cub-1, 0], Down], Right, [Vector[2*Cub-1, 3*Cub-1], Up], Right)
  fuse([Vector[2*Cub,Cub-1], Right], Down, [Vector[2*Cub-1, Cub], Down], Right)
  fuse([Vector[0, 2*Cub], Right], Up, [Vector[Cub, Cub], Down], Left)
  fuse([Vector[Cub, 3*Cub-1], Right], Down, [Vector[Cub-1, 3*Cub], Down], Right)
end

Turns = {'R' => 1, 'L' => -1}
cell = @world_hash[start_pos]
dir = 0

path.each do |i|
  if String === i
    dir += Turns[i]
    dir %= 4
  else
    i.times do
      ncell = cell.nbrs[dir]
      p cell.pos if !ncell
      break if ncell.wall?
      # update dir to the opposite of where we came from
      ndir = (ncell.nbrs.index(cell) + 2) % 4
      cell = ncell
      dir = ndir
    end
  end
end

x, y = cell.pos.to_a.map { _1 + 1 }
p y*1000 + x*4 + dir

