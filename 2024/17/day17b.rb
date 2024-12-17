def it(a)
  b = a & 7
  b ^= 1
  c = a >> b
  b ^= c
  b ^= 4
  b & 7
end

# the code doesn't persist b or c through iterations
# it works for each base 8 digit of a
# construct a digit by digit:

def find(a, digits, i)
  return a if i == digits.size
  8.times.map { a << 3 | _1 }
    .select { it(_1) == digits[i] }
    .flat_map { find(_1, digits, i + 1) }
end

d = File.readlines('input.txt')[-1].strip.split[-1].split(?,).map(&:to_i).reverse

p find(0, d, 0).min
