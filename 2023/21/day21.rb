require 'set'
Dirs = [-1, 1, 1i, -1i]

start = 0
rocks = Set.new
size = nil
File.readlines('input.txt').each.with_index do |l, y|
  l.strip.chars.each.with_index do |c, x|
    pos = x + y * 1i
    case c
    when '#' then rocks << pos
    when 'S' then start = pos
    end
    size = pos
  end
end

size += 1 + 1i

def solve(rocks, size, start, steps)
  visited = Set[start]
  visited_at_step = [1]
  step = [start]

  steps.times do
    new_step = []
    step.each do |pos|
      Dirs.each do |d|
        np = pos + d
        next if rocks === (np.real % size.real + 1i * (np.imag % size.imag))
        next if visited === np
        visited << np
        new_step << np
      end
    end
    visited_at_step << new_step.size
    step = new_step
  end

  visited_at_step.select.with_index { _2.even? == steps.even? }.sum
end

p solve(rocks, size, start, 64) # a

# not the solution to b
# used as input for day21b.wl
# a *correct* solution to be doesn't seem pratical
# so we calculate several values by brute force
# and do perform a quadratic fit in day21b.wl
# (I also checked that the quadratic fit works for 3 and 4 as inputs)
p 3.times.map { solve(rocks, size, start, 65 + 131 * _1) }

