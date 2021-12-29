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
    return nil if rmin.zip(rmax).any? { _1 > _2 }
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
  def subtract_multi(others)
    ret = [self]
    others.each do |o|
      ret.map! { _1 - o }.flatten!
    end
    ret
  end
  def volume
    @min.zip(@max).map { _2 - _1 + 1 }.inject(&:*)
  end
end

input = File.readlines('input.txt').map { |l|
  m = l.strip.match /(\w+) (\d+),(\d+) through (\d+),(\d+)/
  [m[1], Box.new([m[2].to_i, m[3].to_i], [m[4].to_i, m[5].to_i])]
}

# a
on = []
input.each do |op, box|
  new_ons = []
  new_ons = box.subtract_multi(on) if op == 'toggle'
  on.map! { _1 - box }.flatten!
  new_ons = [box] if op == 'on'
  on += new_ons
end
p on.map(&:volume).sum

# b
add = []
input.each do |op, box|
  if op == 'on'
    add << box
  elsif op == 'toggle'
    add += [box] * 2
  else
    r = [box]
    add.map! { |a|
      next a if !(a & box)
      diff = a.subtract_multi(r)
      r.map! { _1 - a }.flatten!
      diff
    }.flatten!
  end
end

p add.map(&:volume).sum
