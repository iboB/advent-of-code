require 'matrix'

def eq(a, ad) = [-ad[1], ad[0], ad[0]*a[1] - ad[1]*a[0]]

def x(a, ad, b, bd)
  a1, b1, c1 = eq(a, ad)
  a2, b2, c2 = eq(b, bd)
  delta = a1*b2 - a2*b1
  return nil if delta == 0
  i = Vector[b2*c1 - b1*c2, a1*c2 - a2*c1] / delta.to_f
  from_a = i - a
  from_b = i - b
  return nil if from_a.dot(ad) < 0 || from_b.dot(bd) < 0
  i
end

input = File.readlines('input.txt').map { |l|
  pts = l.strip.scan(/-?\d+/).map(&:to_i)
  [Vector[*pts[0..1]], Vector[*pts[3..4]]]
}

B = 200000000000000..400000000000000
# B = 7..27

p input.combination(2).map { |(a, ad), (b, bd)|
  x a, ad, b, bd
}.compact.select { |v|
  v.all? { B === _1 }
}.size
