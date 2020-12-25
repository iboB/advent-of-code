require 'matrix'

def s2d(s)
  dirs = []
  s.strip.chars.each do |c|
    if dirs.last == 'n' || dirs.last == 's'
      dirs[-1] += c
    else
      dirs << c
    end
  end
  dirs.map(&:to_sym)
end

D = {
  e:  Vector[+1, -1,  0],
  se: Vector[ 0, -1, +1],
  sw: Vector[-1,  0, +1],
  w:  Vector[-1, +1,  0],
  nw: Vector[ 0, +1, -1],
  ne: Vector[+1,  0, -1],
}

tiles = File.readlines('input.txt').map { |line|
  s2d(line.strip).inject(Vector[0,0,0]) { |v, d|
    v + D[d]
  }.to_a
}.sort.chunk(&:itself).map { |item, chunk|
  item if chunk.length % 2 == 1
}.compact

# a
p tiles.length

# b


class Grid
  def initialize(g=nil)
    @sets = {}
    @counts = Hash.new(0)

    return if !g

    g.counts.each do |vec, n|
      if g.sets[vec]
        set(vec) if n == 1 || n == 2
      elsif n == 2
        set(vec)
      end
    end
  end
  attr :sets, :counts
  def set(vec)
    @sets[vec] = true
    @counts[vec] = 0 if !@counts.key?(vec)
    D.each do |_, d|
      @counts[vec + d] += 1
    end
  end
end

g = Grid.new
tiles.each { |t| g.set(Vector[*t]) }

100.times do |i|
  g = Grid.new(g)
end

puts g.sets.length
