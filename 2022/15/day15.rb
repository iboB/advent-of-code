require 'matrix'
Input = File.readlines('input.txt').map { |l|
  l.scan(/-?\d+/).map(&:to_i)
}

def coverage_at(row)
  ranges = Input.map { |sx, sy, bx, by|
    mh = (sx - bx).abs + (sy - by).abs

    ydist = (sy - row).abs
    cover = mh - ydist
    next if cover < 0

    [sx-cover, sx+cover]
  }.compact.sort_by(&:first)

  out = [ranges[0]]

  ranges[1..].each do |r|
    if out.last[1] >= r[0]
      out.last[1] = r[1] if out.last[1] < r[1]
    else
      out << r
    end
  end

  out
end

# a
AROW = 2_000_000
beacons_on_row = Input.select { _1[3] == AROW }.map { _1[2] }.uniq
a_cov = coverage_at(AROW)
beacons_in_coverage = 0
a_cov.each do |r|
  beacons_on_row.each do |bx|
    beacons_in_coverage += 1 if bx >= r[0] && bx <= r[1]
  end
end
p a_cov.map { _1[1] - _1[0] + 1 }.sum - beacons_in_coverage

# b
# brute-force search every row
def solve(max)
  (0..max).each do |row|
    cov = coverage_at(row).select { _1[1] >= 0 && _1[0] < max }
    if cov.length == 1
      b, e = cov[0]
      return [0, row] if b > 0
      return [max, row] if e < max
    else
      return [cov[0][1] + 1, row]
    end
  end
  [0, 0]
end

x, y = solve(4_000_000)
p x * 4_000_000 + y
