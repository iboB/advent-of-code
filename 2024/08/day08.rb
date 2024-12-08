require 'set'

@max_x = @max_y = 0

ant = Hash.new { |h, k| h[k] = [] }

File.readlines('input.txt').each.with_index { |l, y|
  l.strip.chars.each.with_index { |c, x|
    @max_x = x if x > @max_x
    @max_y = y if y > @max_y
    ant[c] << x + y * 1i if c != ?.
  }
}

def inside(pt) = pt.real >= 0 && pt.imag >= 0 && pt.real <= @max_x && pt.imag <= @max_y

# a
ap = Set[]
ant.each do |freq, coords|
  coords.combination(2).each do |a, b|
    d1 = 2*a - b
    ap << d1 if inside(d1)
    d2 = 2*b - a
    ap << d2 if inside(d2)
  end
end
p ap.size

# b
ap = Set[]
ant.each do |freq, coords|
  coords.combination(2).each do |a, b|
    d1 = a
    while inside(d1)
      ap << d1
      d1 += a - b
    end
    d2 = b
    while inside(d2)
      ap << d2
      d2 += b - a
    end
  end
end
p ap.size
