def solve(nums)
  nums.each_cons(2).select { |pair|
    pair[0] < pair[1]
  }.length
end

input = File.readlines('input.txt').map { |l| l.to_i }

# a
p solve input

# b
p solve input.each_cons(3).map { |t| t.sum }
