p File.readlines('input.txt').map { |l|
  l.scan(/\d+/).map(&:to_i)
}.transpose.flatten.each_slice(3).select { |s|
  a, b, c = s.sort
  a + b > c
}.length
