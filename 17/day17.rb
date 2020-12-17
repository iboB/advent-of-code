require 'matrix'

class Vector
  def x; self[0]; end
  def y; self[1]; end
  def z; self[2]; end
  def x=(c); self[0] = c; end
  def y=(c); self[1] = c; end
  def z=(c); self[2] = c; end
end

class Box
  def initialize(min, max)
    @min = min
    @max = max
  end
  attr :min, :max
  def self.[](min, max)
    Box.new(min, max)
  end
  def add(vec)
    @min = Vector[*@min.zip(vec).map { |p| p.min }]
    @max = Vector[*@max.zip(vec).map { |p| p.max }]
  end
end

mm = [-1,0,1]
Dirs = (mm.product(mm, mm) - [0,0,0]).map { |d| Vector[*d] }

class Grid
  def initialize(n)
    @n = n
    mid = n/2
    @mp = Vector[mid, mid, mid]
    @bounds = Box[@mp, @mp.dup]

    @data = Array.new(n)
    n.times do |z|
      @data[z] = Array.new(n)
      n.times do |y|
        @data[z][y] = Array.new(n)
      end
    end
  end
  attr :n, :mp
  def set(vec)
    @bounds.add(vec + Vector[1,1,1])
    @bounds.add(vec - Vector[1,1,1])
    @data[vec.z][vec.y][vec.x] = true
  end
  def get(vec)
    @data[vec.z][vec.y][vec.x]
  end
  def each
    @bounds.min.z.upto(@bounds.max.z) do |z|
      @bounds.min.y.upto(@bounds.max.y) do |y|
        @bounds.min.x.upto(@bounds.max.x) do |x|
          cur = Vector[x,y,z]
          yield cur
        end
      end
    end
  end
  def dp(z)
    d = @data[z]
    d.each do |col|
      p col
    end
  end
end

lines = File.readlines('input.example').map(&:strip)
s = lines.size

grid = Grid.new(s + 6 + 2)

i = grid.mp - Vector[s/2, s/2, 0]
lines.each { |l|
  i.x = grid.mp.x - s/2
  l.each_char { |c|
    grid.set(i) if c == ?#
    i.x += 1
  }
  i.y += 1
}

rgrid = Grid.new(grid.n)

grid.each do |cur|
  nn = Dirs.map { |d| grid.get(cur + d) }.count(true)
  if grid.get(cur)
    if nn==2 || nn==3
      rgrid.set(cur)
    end
  elsif nn==3
    rgrid.set(cur)
  end
end

sum = 0
rgrid.each { |cur| sum += (grid.get(cur) ? 1 : 0) }

p sum
