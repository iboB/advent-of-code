# revised solution with the Box class I created for 2015/6
# takes 1.3 seconds on the problem input
class Box
  def initialize(min = nil, max = nil)
    @min = min
    @max = max
  end
  attr_accessor :min, :max
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
  def volume
    @min.zip(@max).map { _2 - _1 + 1 }.inject(&:*)
  end
end

on = []
input = File.readlines('input.txt').map { |l|
  op, box = l.strip.split(/,|\s/).yield_self { |s|
    [s[0], Box.new(*s[1..].map { _1.split('=')[1].split('..').map(&:to_i) }.transpose)]
  }
  on.map! { _1 - box }.flatten!
  on << box if op == 'on'
}

# a
p on.map { _1 & Box.new([-50]*3, [50]*3) }.compact.map(&:volume).sum

# b
p on.map(&:volume).sum
