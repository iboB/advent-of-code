p File.readlines('input.txt').select { |l|
  a, b, c = l.scan(/\d+/).map(&:to_i).sort
  a + b > c
}.length
