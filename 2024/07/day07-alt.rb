# alternative solution - backwards search
# 0.1 seconds (including interpreter startup)

sub = -> (x, y){ x - y if x > y }
div = -> (x, y){ x / y if x % y == 0 }
split = -> (x, y){ x / 10**(y.to_s.size) if x.to_s.end_with?(y.to_s) }

def pass(num, parts, ops)
  return num == parts[0] if parts.size == 1
  cp = parts.pop
  ops.map { _1.(num, cp) }.compact.any? { pass(_1, parts.dup, ops) }
end

def solve(input, ops) = input.select { |res, *nums| pass(res, nums, ops) }.sum(&:first)

input = File.readlines('input.txt').map { |l| l.strip.scan(/\d+/).map(&:to_i) }

p solve input, [sub, div]
p solve input, [sub, div, split]
