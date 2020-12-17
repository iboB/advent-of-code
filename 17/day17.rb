require 'matrix'

class Grid
  def initialize(ns, g=nil)
    @ns = ns
    @sets = {}
    @rels = Hash.new(0)

    return if !g

    g.rels.each do |vec, n|
      if g.sets[vec]
        set(vec) if n == 2 || n == 3
      elsif n == 3
        set(vec)
      end
    end
  end
  attr :sets, :rels
  def ncount(vec)
    @ns.count { |d| @sets[vec+d] }
  end
  def set(vec)
    @sets[vec] = true
    @rels[vec] = 0 if !@rels.key?(vec)
    @ns.each do |d|
      @rels[vec + d] += 1
    end
  end
end

d1 = [-1,0,1]
N3 = (d1.product(d1, d1) - [[0,0,0]]).map { |d| Vector[*d] }
N4 = (d1.product(d1, d1, d1) - [[0,0,0,0]]).map { |d| Vector[*d] }

g3 = Grid.new(N3)
g4 = Grid.new(N4)
File.readlines('input.txt').map(&:strip).each_with_index { |l, y|
  l.chars.each_with_index { |c, x|
    if c == '#'
      g3.set(Vector[x, y, 0])
      g4.set(Vector[x, y, 0, 0])
    end
  }
}

6.times do
  ng = Grid.new(N3, g3)
  g3 = ng
  ng = Grid.new(N4, g4)
  g4 = ng
end

p g3.sets.length
p g4.sets.length
