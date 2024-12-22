# bruteforce solution (too slow for ruby)
# rewrtitten in C++ for speed
MOD = 16777216
def gen(num, i)
  i.times.map {
    num ^= num * 64
    num %= MOD
    num ^= num / 32
    num %= MOD
    num ^= num * 2048
    num %= MOD
  }
end

gens = input = File.readlines('input.txt').map(&:to_i).map { [_1] + gen(_1, 2000) }

p gens.sum { _1.last }

prices = gens.map { |g|
  b = g.map { _1%10 }
  [b[1..], b.each_cons(2).map { _2 - _1 }]
}

p 100_000.times.map { |n|
  ("%05d" % n).chars.map(&:to_i).each_cons(2).map { _2 - _1 }
}.to_set.map { |seq|
  seq = seq.flatten
  prices.sum { |p, d|
    i = d.each_cons(seq.size).find_index(seq)
    i ? p[i + seq.size - 1] : 0
  }
}.max
