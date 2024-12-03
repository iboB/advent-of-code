input = File.read('input.txt').strip

def calc(str) = str.scan(/mul\((\d{1,3}),(\d{1,3})\)/).sum { |a, b| a.to_i * b.to_i }

# a
p calc(input)

# b
input = 'do()' + input

p input.split("don't()").map {
  calc _1.split('do()')[1..].join
}.sum
