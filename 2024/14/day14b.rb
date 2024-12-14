# unpleasant
# with the idea that all points participate in the christmas tree i made tests
# that pairs of quadrants have the same number of points, that all points are in one quadrant
# ... but no. The solution is to test that many (but not all) points are in one quadrant

GRID = [101, 103]
input = File.readlines('input.txt').flat_map { |l|
  l.strip.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a.append(GRID).transpose
}

def get_qs(input, step) = input.map { (_1 + _2 * step) % _3 <=> _3 / 2 }.each_slice(2).select { _1 * _2 != 0 }.tally.values

def print_pts(input, step)
  pts = input.map { (_1 + _2 * step) % _3 }.each_slice(2).map { _1 + _2.i }
  puts GRID[1].times.map { |y|
    GRID[0].times.map { |x|
      pts.include?(x + y.i) ? '#' : '.'
    }.join
  }.join("\n")
end

cand = {}

10_000.times { |step|
  qs = get_qs input, step
  if qs[0] == qs[1] && qs[2] == qs[3]
    cand[step] = "01-23"
  elsif qs[0] == qs[2] && qs[1] == qs[3]
    cand[step] = "02-13"
  # elsif qs.any? { _1 == input.size / 2 }
  elsif qs.any? { _1 > input.size / 5 } # thanks, reddit
    cand[step] = "all in one"
  end
}

# p cand.size

cand.each do |step, id|
  puts "#{id}: #{step}"
  print_pts input, step
end
