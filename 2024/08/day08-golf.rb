# an attempt at golfing the solution
@mx = @my = 0

ant = Hash.new { |h, k| h[k] = [] }

File.foreach('input.txt').with_index { |l, y|
  l.strip.chars.each.with_index { |c, x|
    @mx, @my = x, y
    ant[c] << x + y.i if c != ?.
  }
}

def inside(pt) = (0..@mx) === pt.real && (0..@my) === pt.imag

# a
p ant.flat_map { _2.combination(2).flat_map { |a,b| [2*a-b, 2*b-a] } }.uniq.count { inside _1 }

# b
def gen(a, b) = [a].tap { |r| r << r[-1] + a - b while inside(r[-1]) }[..-2]

p ant.flat_map { _2.combination(2).flat_map { |a,b| gen(a, b) + gen(b, a) } }.uniq.size
