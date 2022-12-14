require 'matrix'

min = Vector[500, 0]
max = Vector[0, 0]

input = File.readlines('input.txt').map { |l|
  l.strip.split(' -> ').map {
    x, y = _1.split(',').map(&:to_i)
    min[0] = [min[0], x].min
    min[1] = [min[1], y].min
    max[0] = [max[0], x].max
    max[1] = [max[1], y].max
    Vector[x, y]
  }
}

Buf = 1000
min[0] -= Buf
max -= min
max[1] += 1

grid = Array.new(max[1]+1) { Array.new(max[0]+Buf, '.') }

input.each do |poly|
  prev = nil
  poly.each do |coord|
    coord -= min
    if !prev
      prev = coord
      next
    end

    if coord[0] == prev[0]
      x = coord[0]
      r = [prev[1], coord[1]].sort
      (r[0]..r[1]).each do |y|
        grid[y][x] = '#'
      end
    else
      y = coord[1]
      r = [prev[0], coord[0]].sort
      (r[0]..r[1]).each do |x|
        grid[y][x] = '#'
      end
    end

    prev = coord
  end
end

start = Vector[500, 0] - min

Dirs = [Vector[0,1], Vector[-1,1], Vector[1,1]]

rest = 0
check = -> (g) {
  Dirs.each do |d|
    n = g + d
    if n[1] > max[1]
      grid[g[1]][g[0]] = 'O'
      rest += 1
      return nil
    end
    return n if grid[n[1]][n[0]] == '.'
  end
  rest += 1
  grid[g[1]][g[0]] = 'O'
  nil
}

a_asnwered = false

active_grains = []
while true do
  active_grains = active_grains.map { |g|
    check.(g)
  }.compact

  break if grid[start[1]][start[0]] != '.'
  active_grains << start

  if active_grains[0][1] == max[1] - 1
    if !a_asnwered
      p rest
      a_asnwered = true
    end
  end
end

# puts grid.map { _1.join }.join("\n")
puts rest



