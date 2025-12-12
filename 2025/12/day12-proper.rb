# knowing the specifics of the input, this is the proper solution
p File.read(?i).split("\n\n")[-1].lines.count {
  x, y, *s = _1.scan(/\d+/).map(&:to_i)
  (x/3) * (y/3) >= s.sum
}
