input = File.readlines(?i).map { |l|
  l.split(?,).map(&:to_i)
}

# find border (and sort each segment's coords)

border = (input + input[...1]).each_cons(2).map {
  [_1, _2].transpose.map(&:sort).transpose
}

# for each candidate check if it intersects with border
# if yes, negative area (part A), else positive area (part B)

p input.combination(2).map {
  (ax, bx), (ay, by) = [_1, _2].transpose.map(&:sort)
  sign = border.find { |(bax, bay), (bbx, bby)|
    bbx > ax && bax < bx && bby > ay && bay < by
  } ? -1 : 1
  sign * (bx - ax + 1) * (by - ay + 1)
}.minmax.map(&:abs)

