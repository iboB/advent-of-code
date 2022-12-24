require 'matrix'

Dirs = [Vector[1, 0], Vector[-1, 0], Vector[0, 1], Vector[0, -1]]
DC = {'>' => Vector[1, 0], '<' => Vector[-1, 0], 'v' => Vector[0, 1], '^' => Vector[0, -1]}

w = 0
h = 0
Bliz = File.readlines('input.txt')[1..-2].map.with_index { |l, y|
  h = y + 1
  l.strip.split(//)[1..-2].map.with_index { |c, x|
    w = x + 1
    [Vector[x, y], DC[c]] if c != ?.
  }.compact
}.flatten(1)

W = w
H = h

Grids = H.lcm(W).times.map {
  grid = H.times.map { [1] * W }
  Bliz.each do |pos, _|
    grid[pos[1]][pos[0]] = nil
  end
  Bliz.each do |pos, dir|
    pos[0..] = pos + dir
    pos[0] %= W
    pos[1] %= H
  end
  grid
}

def solve(minute0, start, target)
  timeline = []
  memo = {}
  minute0.step do |minute|
    ngi = (minute + 1) % Grids.size
    ng = Grids[ngi]

    nt = []

    test_and_add = ->(pos) {
      return if !ng[pos[1]][pos[0]]
      return if memo[[pos, ngi]]
      memo[[pos, ngi]] = true
      nt << pos
    }

    test_and_add.(start) if (minute - minute0) <= Grids.size

    timeline.each do |pos|
      test_and_add.(pos)
      Dirs.each do |d|
        np = pos + d
        return minute + 1 if np == target
        next if np[0] < 0 || np[0] >= W
        next if np[1] < 0 || np[1] >= H
        test_and_add.(np)
      end
    end

    timeline = nt
  end
end

ab = solve(0, Vector[0, 0], Vector[W-1, H])
p ab
ba = solve(ab, Vector[W-1, H-1], Vector[0, -1])
p solve(ba, Vector[0, 0], Vector[W-1, H])







