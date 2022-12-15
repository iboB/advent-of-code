# A simulation solution
# I'm sure there's a projection-based one, which doesn't simulate every grain,
# but for now I wont invest in such

require 'matrix'
require 'set'

bottom = 0

input = File.readlines('input.txt').map { |l|
  l.strip.split(' -> ').map {
    x, y = _1.split(',').map(&:to_i)
    bottom = [bottom, y].max
    Vector[x, y]
  }
}

bottom += 1

map = Set.new

input.each do |poly|
  prev = poly[0]
  poly[1..].each do |coord|
    c = 0
    r = [coord[0], prev[0]]
    if coord[0] == prev[0]
      c = 1
      r = [coord[1], prev[1]]
    end
    (r.min..r.max).each do |i|
      prev[c] = i
      map << prev.dup
    end
    prev = coord
  end
end

grains = 0
a_done = false

Dirs = [Vector[0,1], Vector[-1,1], Vector[1,1]]

while true do
  g = Vector[500, 0]
  break if map.include? g
  while true do
    n = Dirs.map { _1 + g }.find { !map.include? _1 }
    break if !n
    break if n[1] > bottom
    # a
    if !a_done && n[1] == bottom
      p grains
      a_done = true
    end
    g = n
  end
  map << g
  grains += 1
end

p grains

