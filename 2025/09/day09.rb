input = File.readlines(?i).map { |l| l.split(?,).map(&:to_i) }

# find border (and sort each segment's coords)

border = (input + input[...1]).each_cons(2).map {
  _1.transpose.map(&:sort).flatten
}

# for each candidate check if it intersects with border
# if yes, negative area (part A), else positive area (part B)

p input.combination(2).map { |co|
  (ax, bx), (ay, by) = co.transpose.map(&:sort)
  sign = border.any? { _1 < bx && _2 > ax && _3 < by && _4 > ay } ? -1 : 1
  sign * (bx - ax + 1) * (by - ay + 1)
}.minmax.map(&:abs)
