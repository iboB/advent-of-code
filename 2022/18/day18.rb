require 'matrix'

sides = Hash.new(0)

input = File.readlines('input.txt').map { |l|
  cube = Vector[*l.strip.split(',').map { _1.to_i + 1 }] # add one so as to leave zero empty
  sides[[cube, :r]] += 1
  sides[[cube, :d]] += 1
  sides[[cube, :i]] += 1
  sides[[cube - Vector[1, 0, 0], :r]] += 1
  sides[[cube - Vector[0, 1, 0], :d]] += 1
  sides[[cube - Vector[0, 0, 1], :i]] += 1
  cube.to_a
}

# a
p sides.values.count(1)

# b
SIZE = input.transpose.map { _1.max + 2 } # add 2 so as to leave max empty

class Mut # mutable value ( sometimes ruby doesn't help us :( )
  def initialize(v)
    @v = v
  end
  attr_accessor :v
end

@grid = Array.new(SIZE[2]) { Array.new(SIZE[1]) { Array.new(SIZE[0]) { Mut.new(false) } } }
input.each { |v| @grid[v[2]][v[1]][v[0]] = nil } # clear set

def at(v)
  return nil if v.any? { _1 < 0 }
  return nil if v.zip(SIZE).any? { _1 >= _2 }
  return @grid[v[2]][v[1]][v[0]]
end

# floodfill
area = 0
Dirs = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [-1, 0, 0], [0, -1, 0], [0, 0, -1]].map { Vector[*_1] }
bfs = [Vector[0, 0, 0]]
while !bfs.empty? do
  cur = bfs.shift
  Dirs.each do |d|
    pos = cur + d
    val = at(pos)
    next if !val || val.v
    val.v = true
    # count neighbouring edges
    area += 1 if sides[[pos, :r]] == 1
    area += 1 if sides[[pos, :d]] == 1
    area += 1 if sides[[pos, :i]] == 1
    bfs << pos
  end
end

p 2 * area
