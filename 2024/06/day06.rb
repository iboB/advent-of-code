require 'set'
start = nil
@max_x = 0
@max_y = 0

obstacles = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    @max_x = x if x > @max_x
    @max_y = y if y > @max_y
    coord = x + y * 1i
    start = coord if c == ?^
    coord if c == ?#
  }
}.compact.to_set

def solve(pos, obstacles)
  dir = -1i
  vis = Hash.new { |h, k| h[k] = Set.new }

  while true
    break if pos.imag < 0 || pos.imag > @max_y || pos.real < 0 || pos.real > @max_x

    dir *= 1i while obstacles === pos + dir

    throw :loop, true if vis[pos] === dir
    vis[pos] << dir

    pos += dir
  end

  vis
end

initial = solve(start, obstacles)

# a
p initial.size

# b
p initial.keys.count { |pos|
  catch :loop do
    !solve(start, obstacles.dup.add(pos))
  end
}
