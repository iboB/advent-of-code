# Well, I fell for it
# I spent 40 minutes trying to think of something clever and then decided
# to look at a concrete non-trivial input case... and yeah...

shapes, regions = File.read(?i).split("\n\n").then { |*shapes, regions|
  [
    shapes.map { |s|
      s.lines[1..].flat_map.with_index { |line, y|
        line.chars.map.with_index { |c, x| x + y.i if c == ?# }.compact
      }
    },
    regions.lines.map {
      _1.scan(/\d+/).map(&:to_i).then { |x, y, *s| [[x, y], s]}
    }
  ]
}

trivial_deny = []
trivial_accept = []
non_trivial = []

regions.map { |r|
  (x, y), nshapes = r
  rvolume = x * y
  svolume = nshapes.map.with_index { _1 * shapes[_2].size }.sum
  gvolume = (x/3) * (y/3)
  if rvolume < svolume
    trivial_deny << r
  elsif gvolume >= nshapes.sum
    trivial_accept << r
  else
    non_trivial << r
  end
}

p trivial_deny.size
p trivial_accept.size
p non_trivial.size
