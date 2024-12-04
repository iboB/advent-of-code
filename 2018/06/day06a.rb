pts = File.readlines('input.txt').map { |l|
  x, y = l.strip.split(', ').map(&:to_i)
  x + y.i
}

min = pts.map(&:real).min + pts.map(&:imag).min.i

pts.map! { _1 - min }

max_x = pts.map(&:real).max
max_y = pts.map(&:imag).max

area = Hash.new(0)

def closest(cur, pts)
  c = pts.group_by { |pt|
    (cur - pt).then { _1.real.abs + _1.imag.abs }
  }.min[1]
  c.size == 1 ? c[0] : -1 # return some bs value in nowhere if tie
end

# find area in interior
(1...max_x).each { |x|
  (1...max_y).each { |y|
    cur = x + y.i
    area[closest(cur, pts)] += 1
  }
}

# remove areas which reach the edge (infinite)
(max_x + 1).times { |x|
  area.delete(closest(x, pts))
  area.delete(closest(x + max_y.i, pts))
}
(max_y + 1).times { |y|
  area.delete(closest(y.i, pts))
  area.delete(closest(max_x + y.i, pts))
}

area.delete(-1) # remove bs point if it still remains

p area.values.max
