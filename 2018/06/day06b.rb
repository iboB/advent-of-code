PTS = File.readlines('input.txt').map { |l|
  l.strip.split(', ').map(&:to_i)
}

def td(x, y) = PTS.sum { (x - _1).abs + (y - _2).abs }

# limits are experimental and may not work for all inputs
test_set = (0..400).to_a
p test_set.product(test_set).count { td(_1, _2) < 10000 }
