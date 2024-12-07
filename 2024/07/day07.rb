# brute force taking 25 seconds to check all possibilities
# could be optimized a lot... maybe some day

def can_build(num_ops, num, parts)
  inv = num_ops ** (parts.size - 1)
  return num if inv.times.find { |v|
    num == parts.inject { |a, b|
      break if a > num
      v, op = v.divmod(num_ops)
      case op
        when 0 then a + b
        when 1 then a * b
        when 2 then "#{a}#{b}".to_i
      end
    }
  }
end

def solve(num_ops, input) = input.map { |res, *nums| can_build(num_ops, res, nums) }.compact.sum

input = File.readlines('input.txt').map { |l| l.strip.scan(/\d+/).map(&:to_i) }

p solve(2, input)
p solve(3, input)
