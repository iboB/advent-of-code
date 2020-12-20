tiles = File.read('input.txt').split("\n\n").map { |tile|
  tile = tile.lines.map(&:strip).to_a
  tile[0] =~ /^Tile (\d+):$/
  id = $1.to_i

  tile = tile[1..]
  e = [] # edges

  e[0] = tile[0]
  e[2] = tile[-1].reverse
  tile = tile.map { |row| row.split(//) }.transpose
  e[1] = tile[-1].join
  e[3] = tile[0].join.reverse

  pos = 4.times.map { |i| e.rotate(i) }

  # flip
  e[1], e[3] = e[3], e[1]
  e.map!(&:reverse)

  pos += 4.times.map { |i| e.rotate(i) }

  # bottom and left in the same direction as top and right
  pos.each { |es|
    es[2] = es[2].reverse
    es[3] = es[3].reverse
    es << id
  }

  pos
}

class Array
  def without(i)
    r = self.dup
    r.delete_at(i)
    r
  end
end

class Grid
  def initialize(size)
    @size = size
    @x = 0
    @y = 0

    @data = size.times.map { [] }
  end
  def mul_corners
    @data[0][0][-1] * @data[-1][0][-1] * @data[0][-1][-1] * @data[-1][-1][-1]
  end
  def push(pos)
    return false if @x != 0 && @data[@y][@x-1][1] != pos[3]
    return false if @y != 0 && @data[@y-1][@x][2] != pos[0]
    @data[@y][@x] = pos
    @x += 1
    if @x == @size
      @x = 0
      @y += 1
    end
    true
  end
  def pop
    if @x == 0
      @y -= 1
      @x = @size - 1
    else
      @x -= 1
    end
  end
end

def solve(ar, grid)
  return grid if ar.empty?
  ar.each_with_index do |tile, i|
    tile.each do |pos|
      if grid.push(pos)
        r = solve(ar.without(i), grid)
        return r if r
        grid.pop
      end
    end
  end
  nil
end

p solve(tiles, Grid.new(Math.sqrt(tiles.length).to_i)).mul_corners
