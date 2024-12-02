reps = File.readlines('input.txt').map { _1.split.map(&:to_i) }

INC = 1..3
DEC = -3..-1

# a
p reps.count { |r|
  diffs = r.each_cons(2).map { _1 - _2 }
  diffs.all? { INC === _1 } || diffs.all? { DEC === _1 }
}

# b
def find_bad(r, range) = r.each_cons(2).map { _1 - _2 }.find_index { !(range === _1) }

def good(r, range)
  i = find_bad(r, range)
  return true if !i
  return true if !find_bad(r.dup.tap { _1.delete_at(i) }, range)
  !find_bad(r.dup.tap { _1.delete_at(i + 1) }, range)
end

p reps.count { good(_1, INC) || good(_1, DEC) }
