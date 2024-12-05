require 'set'

RULES, TESTS = File.read('input.txt').split("\n\n").map(&:split).then {
  [_1.to_set, _2.map { |r| r.split(?,) }]
}

def ms(ar) = ar.sum { _1[_1.size / 2].to_i }

def cmp(a, b)
  return -1 if RULES === a+?|+b
  return 1 if RULES === b+?|+a
  0
end

acc, rej =  TESTS.partition { |t|
  t.each_cons(2).all? { cmp(_1, _2) != 1 }
}

# a
p ms acc

# b
p ms rej.map { |t| t.sort { cmp(_1, _2) } }
