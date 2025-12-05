ranges, ids = File.read(?i).strip.split("\n\n").then {[
  _1.lines.map{|l| l.split(?-).map(&:to_i)},
  _2.lines.map(&:to_i)
]}

# b
# sweep line:
# store depth, collect begins with depth 0->1 and ends with depth 1->0

points = []

ranges.each { |first, last|
  points << [first, :begin]
  points << [last + 1, :end]
}

points.sort!

depth = 0
cur_start_pos = 0
non_overlapping = []
points.each { |pos, type|
  if type == :begin
    if depth == 0
      # going from 0 to 1
      cur_start_pos = pos
    end
    depth += 1
  else
    depth -= 1
    if depth == 0
      # going from 1 to 0
      non_overlapping << [cur_start_pos, pos]
    end
  end
}

total_length = non_overlapping.sum { |first, last| last - first }
p total_length
