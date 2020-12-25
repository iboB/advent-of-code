require 'matrix'

class Grid
  def initialize(dirs, g=nil)
    @dirs = dirs
    @sets = {}
    @counts = Hash.new(0)

    return if !g

    g.counts.each do |vec, n|
      if g.sets[vec]
        set(vec) if n == 2 || n == 3
      elsif n == 3
        set(vec)
      end
    end
  end
  attr :sets, :counts
  def ncount(vec)
    @dirs.count { |d| @sets[vec+d] }
  end
  def set(vec)
    @sets[vec] = true
    @counts[vec] = 0 if !@counts.key?(vec)
    @dirs.each do |d|
      @counts[vec + d] += 1
    end
  end
end

d1 = [-1,0,1]
D3 = (d1.product(d1, d1) - [[0,0,0]]).map { |d| Vector[*d] }
D4 = (d1.product(d1, d1, d1) - [[0,0,0,0]]).map { |d| Vector[*d] }

g3 = Grid.new(D3)
g4 = Grid.new(D4)
File.readlines('input.txt').map(&:strip).each_with_index { |l, y|
  l.chars.each_with_index { |c, x|
    if c == '#'
      g3.set(Vector[x, y, 0])
      g4.set(Vector[x, y, 0, 0])
    end
  }
}

6.times do
  g3 = Grid.new(D3, g3)
  g4 = Grid.new(D4, g4)
end

p g3.sets.length
p g4.sets.length
