fs = File.readlines('input.txt').map(&:to_i)

# a
p fs.sum

# b
sum = 0
reached = {}

fs.cycle do |f|
  reached[sum] = true
  sum += f
  break if reached[sum]
end

p sum



