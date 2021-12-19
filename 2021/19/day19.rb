# kinda brute-forcey, but it was the easiest to write
# there are many many places to optimize
# takes 5 seconds on the problem input

require 'matrix'

MAT_24 = [Vector[1,0,0], Vector[0,1,0], Vector[0,0,1]].permutation(2).map { |a, b|
  [[a, b], [a, -b], [-a, b], [-a, -b]]
}.flatten(1).map { |a, b|
  Matrix[a, b, a.cross(b)]
}

class Array
  def multi_i(other)
    each_with_object(other.dup).map { |v, t|
      v if (l = t.index v) && t.slice!(l)
    }.compact
  end
end

class Vector
  def dsq(o)
    self.zip(o).map { (_1 - _2) ** 2 }.sum
  end
  def md(o)
    self.zip(o).map { (_1 - _2).abs }.sum
  end
end

class Scanner
  def initialize(beacons)
    @beacons = beacons
    @ds = beacons.map { |b|
      beacons.map { |b2|
        b.dsq(b2)
      }
    }
    @vs = beacons.map { |b|
      beacons.map { |b2|
        b2 - b
      }
    }
    @links = {}
    @ps = [Vector[0,0,0]]
  end

  def match?(si, other, oi)
    MAT_24.each do |m|
      return m if (vs[si] & other.vs[oi].map { m * _1 }).length >= 12
    end
  end

  def test(other)
    sl = beacons.length
    ol = other.beacons.length

    sl.times do |si|
      ol.times do |oi|
        dist_matches = ds[si].multi_i(other.ds[oi])
        next if dist_matches.length < 12
        # we have matching distances
        # now rotate other every which way to test for matching vectors
        t = match?(si, other, oi)
        next if !t

        return [si, t, oi]
      end
    end

    return nil
  end

  def keep!(i)
    @keep = i
  end

  def recalc_keep_v
    return if !@keep
    b = beacons[@keep]
    vs[@keep] = beacons.map { |b2|
      b2 - b
    }
  end

  def take_links
    links.each do |tdata, others|
      si, t, oi = *tdata
      others.each do |other|
        @beacons += other.vs[oi].map { t * _1 + beacons[si] }
        @ps += other.ps.map { t * (_1 - other.beacons[oi]) + beacons[si] }
      end
    end
    recalc_keep_v
  end

  attr_reader :beacons, :ds, :vs, :ps
  attr_accessor :links
end

input = File.read('input.txt').strip.split("\n\n").map { |s|
  Scanner.new s.lines.map(&:strip)[1..].map { Vector[*_1.split(',').map(&:to_i)] }
}

matched = [input.shift]
mi = 0

while input
  cm = matched[mi]
  grouped = input.group_by {
    cm.test _1
  }
  input = grouped[nil]
  grouped.delete nil
  cm.links = grouped

  grouped.each do |tdata, ss|
    si, t, oi = *tdata
    ss.each do |scanner|
      scanner.keep! oi
    end
  end

  matched += grouped.values.flatten
  mi += 1
end

# matched in reverse order

matched.reverse.each { _1.take_links }

# a
p matched[0].beacons.uniq.length

# b
p matched[0].ps.combination(2).map { _1.md(_2) }.max
