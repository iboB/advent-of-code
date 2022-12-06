def solve(input, n)
  ar = input.shift n-1
  input.each_with_index do |c, i|
    ar << c
    return i + n if ar.uniq.length == n
    ar.shift
  end
end

input = File.read('input.txt').strip.split(//)

p solve input.dup, 4
p solve input.dup, 14


