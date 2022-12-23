# brute forced simulation
# took 73 seconds for part 2
require 'matrix'
require 'set'

@elves = Set.new File.readlines('input.txt').map.with_index { |l, y|
  l.strip.split(//).map.with_index { |c, x|
    Vector[x, y] if c == ?#
  }.compact
}.flatten

N = Vector[0, -1]
E = Vector[1, 0]
S = Vector[0, 1]
W = Vector[-1, 0]

Looks = [[N, N+E, N+W], [S, S+E, S+W], [W, N+W, S+W], [E, N+E, S+E]]

def bb
  xs, ys = @elves.to_a.map(&:to_a).transpose
  [(xs.min..xs.max), (ys.min..ys.max)]
end

def round
  proposed = {}
  @elves.each do |e|
    free = Looks.map { |t| t.map { !@elves.include?(e + _1) }.all? }
    next if free.all? || free.none?
    proposal = e + Looks[free.index(true)][0]
    proposed[proposal] = [] if !proposed[proposal]
    proposed[proposal] << e
  end

  moves = 0
  proposed.each do |pos, elves|
    next if elves.size != 1
    moves += 1
    @elves.delete(elves[0]) << pos
  end

  Looks.rotate!
  moves
end

p 1.step { |r|
  break r if round == 0
  if r == 10 # part 1
    box = bb
    puts box[0].size * box[1].size - @elves.size
  end
}
