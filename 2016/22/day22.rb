input = File.readlines('input.txt')[2..].map { |l|
  node_x, node_y, size, used, avail, use = l.strip.scan(/\d+/).map(&:to_i)
  [[node_x, node_y], used, avail]
}

puts input.permutation(2).to_a.select { |a, b|
  a[1] != 0 && a[1] <= b[2]
}.length
