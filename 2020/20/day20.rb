class Vec
  def initialize(x, y)
    @x = x
    @y = y
  end
  attr :x, :y
  def self.[](x, y)
    Vec.new(x, y)
  end
end

class Img
  def initialize(rows)
    @data = rows
  end
  attr :data
  def rotated()
    Img.new(@data.transpose).hflipped
  end
  def hflipped()
    Img.new @data.map(&:reverse)
  end
  def to_s
    @data.map(&:join).join("\n")
  end
  def borders
    t = @data[0]
    b = @data[-1]
    l, r = @data.map { |row| [row[0], row[-1]] }.transpose
    [t, r, b, l].map(&:join)
  end
  def peeled
    Img.new @data[1..-2].map { |row| row[1..-2] }
  end
  def match_row?(pos, row)
    @data[pos.y][pos.x...pos.x+row.length].zip(row).all? { |a,b| b == ' ' || a == b }
  end
  def match_img?(pos, other)
    other.data.each_with_index.all? { |row, i|
      match_row?(Vec[pos.x, pos.y+i], row)
    }
  end
  def has_match?(other)
    (@data.length-other.data.length+1).times do |y|
      (@data[y].length-other.data[0].length+1).times do |x|
        return true if match_img?(Vec[x, y], other)
      end
    end
    false
  end
  def count(c)
    @data.map { |r| r.count(c) }.sum
  end
  def num_matches(other)
    num = 0
    (@data.length-other.data.length+1).times do |y|
      (@data[y].length-other.data[0].length+1).times do |x|
        num += 1 if match_img?(Vec[x, y], other)
      end
    end
    num
  end
end

class Tile
  def initialize(id, img)
    @id = id
    @t, @r, @b, @l = img.borders
    @img = img.peeled
  end
  attr :id, :t, :r, :b, :l, :img
end

tiles = File.read('input.txt').split("\n\n").map { |tile|
  tile = tile.lines.map(&:strip).to_a
  tile[0] =~ /^Tile (\d+):$/
  id = $1.to_i

  img = Img.new(tile[1..].map(&:chars))
  res = 4.times.map {
    t = Tile.new(id, img)
    img = img.rotated
    t
  }
  img = img.hflipped
  res + 4.times.map {
    t = Tile.new(id, img)
    img = img.rotated
    t
  }
}

class Grid
  def initialize(size)
    @size = size
    @x = 0
    @y = 0

    @data = size.times.map { [] }
  end
  def mul_corners
    @data[0][0].id * @data[-1][0].id * @data[0][-1].id * @data[-1][-1].id
  end
  def join
    Img.new @data.map { |dr|
      imgs = dr.map { |tile| tile.img.data }
      first, *rest = imgs
      first.zip(*rest).map { |jr|
        jr.flatten
      }
    }.flatten(1)
  end
  def push(pos)
    return false if @x != 0 && @data[@y][@x-1].r != pos.l
    return false if @y != 0 && @data[@y-1][@x].b != pos.t
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

class Array
  def without(i)
    r = self.dup
    r.delete_at(i)
    r
  end
end

def solve_puzzle(ar, grid)
  return grid if ar.empty?
  ar.each_with_index do |tile, i|
    tile.each do |pos|
      if grid.push(pos)
        r = solve_puzzle(ar.without(i), grid)
        return r if r
        grid.pop
      end
    end
  end
  nil
end

g = solve_puzzle(tiles, Grid.new(Math.sqrt(tiles.length).to_i))
p g.mul_corners

# puts g.join.rotated.hflipped

monster = <<DATA
                  #
#    ##    ##    ###
 #  #  #  #  #  #
DATA
monster = Img.new(monster.lines.map(&:chop).map(&:chars))

img = g.join
forms = 4.times.map { img = img.rotated }
img = img.hflipped
forms += 4.times.map { img = img.rotated }

p img.count('#') - forms.find { |f| f.has_match?(monster) }.num_matches(monster) * monster.count('#')
