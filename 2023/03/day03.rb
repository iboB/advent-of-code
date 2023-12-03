class PartId
  def initialize(n)
    @n = n
    @syms = 0
  end
  attr_accessor :n, :syms
end

class MySym
  def initialize(s)
    @s = s
    @ids = []
  end
  attr_accessor :s, :ids
end

ints = []
gears = []

input = File.readlines('input.txt').map { |l|
  l.scan(/(\d+)|(.)/).map { |num, sym|
    next nil if sym == ?.
    if sym
      my = MySym.new sym
      gears << my if sym == ?*
      my
    else
      my = PartId.new num.to_i
      ints << my
      [my] * num.length
    end
  }.flatten
}

def neighbors(img, x, y)
  ret = []
  (y-1..y+1).each do |iy|
    next if iy < 0 || iy >= img.length
    row = img[iy]
    (x-1..x+1).each do |ix|
      next if ix == x && iy == y # don't count self
      next if ix < 0 || ix >= row.length
      ret << row[ix]
    end
  end
  ret.compact
end

input.each.with_index do |line, y|
  line.each.with_index do |c, x|
    next if !(MySym === c)
    neighbors(input, x, y).select { PartId === _1 }.uniq.each do
      _1.syms += 1
      c.ids << _1.n
    end
  end
end

# a
p ints.select { _1.syms != 0 }.map(&:n).sum

# b
p gears.map(&:ids).select { _1.length == 2 }.map { _1 * _2 }.sum

