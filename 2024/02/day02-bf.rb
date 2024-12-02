# brute foce which in hindsight was much simpler than the original solution
# no point in being too clever

def good(r) = r.each_cons(2).map { _1 - _2 }.all? { (1..3) === _1 }
def good_sans_1(r) = r.combination(r.size - 1).any? { good _1 }

reps = File.readlines('input.txt').map { _1.split.map(&:to_i) }
reps += reps.map(&:reverse)

# a
p reps.count { good _1 }

# b (no point in checking a here, since if it's good, it's also good without one element)
p reps.count { good_sans_1 _1 }
