# make use of the fact that all numbers are less than 100
# and use an array with direct indexing instead of set

rules, tests = File.read('input.txt').split("\n\n").map(&:split).map { |i|
  i.map { _1.scan(/\d+/).map(&:to_i) }
}

CMP = [0] * 10_000
rules.each { |a,b|
  CMP[a*100 + b] = -1
  CMP[b*100 + a] = 1
}

def ms(ar) = ar.sum { _1[_1.size / 2].to_i }
def cmp(a, b) = CMP[a*100 + b]

acc, rej = tests.partition { |t|
  t.each_cons(2).all? { cmp(_1, _2) != 1 }
}

# a
p ms acc

# b
p ms rej.map { |t| t.sort { cmp(_1, _2) } }
