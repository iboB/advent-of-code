input = File.read('input.txt').strip.split(',').map(&:to_i)

max = input.max + 1

# a
p max.times.map { |i|
  input.map { |c| (c - i).abs }.sum
}.min

# b
p max.times.map { |i|
  input.map { |c|
    n = (c - i).abs
    (n * (n+1))/2
  }.sum
}.min


