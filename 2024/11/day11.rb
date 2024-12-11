input = File.read('input.txt').strip.split.map(&:to_i)

@mpl = 100.times.map { {} }

def count(n, l)
  return 1 if l == 0
  memo = @mpl[l]
  return memo[n] if memo[n]
  memo[n] = if n == 0
    count(1, l-1)
  elsif (s = n.to_s).size.even?
    h1, h2 = s[..s.size/2-1], s[s.size/2..]
    count(h1.to_i, l-1) + count(h2.to_i, l-1)
  else
    count(n * 2024, l-1)
  end
end

puts [25, 75].map { |d| input.sum { count(_1, d) } }
