grid = Array.new(100)
grid2 = grid.dup
100.times do |z|
  grid[z] = Array.new(100)
  grid2[z] = Array.new(100)
  100.times do |y|
    grid[y] = Array.new(100)
    grid2[y] = Array.new(100)
  end
end

class Integer
  def min(o); self > o ? o : self; end
  def max(o); self < o ? o : self; end
end

lines = File.readlines('input.example').map(&:strip)

minx = 50
miny = 50
minz = 50

maxx = 50
maxy = 50
maxz = 50

y = 50-lines.length/2
lines.each { |l|
  x = 50-l.length/2
  l.each_char { |c|
    grid[y][x] = true if c == '#'
    ++x
    minx = minx.min(x)
    maxx = maxx.max(x)
  end
  ++y
  miny = miny.min(y)
  maxy = maxy.max(y)
end

mm = [-1,0,1]
neighbors = mm.product(mm, mm) - [0,0,0]