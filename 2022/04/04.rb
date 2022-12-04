input = File.readlines('input.txt').map { |l|
  l.strip.split(',').map { |i|
    i.split('-').map(&:to_i).yield_self { |b, e| b..e }
  }
}

# a
p input.select { |a, b| (a.cover? b) || (b.cover? a) }.length

# b
p input.select { |a, b| !(a.last < b.first || b.last < a.first) }.length
