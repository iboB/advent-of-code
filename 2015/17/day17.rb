Input = File.readlines('input.txt').map(&:to_i).sort.reverse

@found = []

def solve(ind, comb, c)
  (ind...Input.size).each do |i|
    nc = Input[i] + c
    case nc <=> 150
    when -1 then solve(i + 1, comb + [i], nc)
    when 0 then @found << comb + [i]
    end
  end
end

solve(0, [], 0)

# a
p @found.length

# b
len = @found.map(&:size).min
p @found.select { _1.size == len }.length
