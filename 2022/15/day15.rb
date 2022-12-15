require 'matrix'
input = File.readlines('input.txt').map { |l|
  l.scan(/\d+/).map(&:to_i)
}

ROW = 2_000_000

beakons_on_row = input.select { _1[3] == ROW }.map { _1[2] }.uniq
sensors_on_row = input.select { _1[1] == ROW }.map { _1[0] }.uniq

ranges = input.map { |sx, sy, bx, by|
  mh = (sx - bx).abs + (sy - by).abs

  ydist = (sy - ROW).abs
  cover = mh - ydist
  next if cover <= 0

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

beakons_in_coverage = 0
sensors_in_coverage = 0
out.each do |r|
  beakons_on_row.each do |bx|
    beakons_in_coverage += 1 if bx >= r[0] && bx <= r[1]
  end
  sensors_on_row.each do |sx|
    sensors_in_coverage += 1 if sx >= r[0] && sx <= r[1]
  end
end

p ranges
p out

p beakons_in_coverage
p sensors_in_coverage

p out.map { _1[1] - _1[0] + 1 }.sum - beakons_in_coverage








