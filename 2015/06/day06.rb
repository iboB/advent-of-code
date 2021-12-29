class Range
  def &(other)
    return nil if (self.max < other.begin or other.max < self.begin)
    [self.begin, other.begin].max..[self.max, other.max].min
  end
  def -(other)
    i = self & other
    return [self] if !i
    ret = []
    ret << (self.min..other.min-1) if other.min > self.min
    ret << (other.max+1..self.max) if other.max < self.max
    ret
  end
end

class Box
  def initialize(min = nil, max = nil)
    @min = min
    @max = max
  end
  attr_accessor :min, :max
  def inside?(pt)
    @min.zip(pt, @max).all? {
      _1 <= _2 && _2 <= _3
    }
  end
  def &(other)
    rmin = @min.zip(other.min).map(&:max)
    rmax = @max.zip(other.max).map(&:min)

    return nil if @min.zip(@max).any? { _1 > _2 }
    Box.new(rmin, rmax)
  end
  def -(other)
    i = self & other
    return self if !i
    ret = []

    cmin = @min.dup
    cmax = @max.dup

    i.min.zip(i.max).each_with_index { |z, d|
      imin, imax = *z
      if cmin[d] < imin
        rmin, rmax = cmin.dup, cmax.dup
        rmin[d] = cmin[d]
        rmax[d] = imin - 1
        cmin[d] = imin
        ret << Box.new(rmin, rmax)
      end

      if imax < cmax[d]
        rmin, rmax = cmin.dup, cmax.dup
        rmin[d] = imax + 1
        rmax[d] = cmax[d]
        cmax[d] = imax
        ret << Box.new(rmin, rmax)
      end
    }

    ret
  end
  def volume
    @min.zip(@max).map { _2 - _1 + 1 }.inject(&:*)
  end
end

level = [Box.new([0, 0], [999, 999])]
on = []

File.readlines('input.txt').map { |l|
  m = l.strip.match /(\w+) (\d+),(\d+) through (\d+),(\d+)/
  [m[1], Box.new([m[2].to_i, m[3].to_i], [m[4].to_i, m[5].to_i])]
}.reverse.each { |op, b|
  on += level.map { _1 & b }.compact if op == 'on'

  if op == 'toggle'
  else
  end
}

