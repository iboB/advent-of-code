# brute foce which in hindsight was much simpler than the original solution
# no point in being too clever

def good(r) = r.each_cons(2).map { _1 - _2 }.all? { (1..3) === _1 }
def good_sans_1(r) = r.each_index.any? { |i| good(r.dup.tap { _1.delete_at(i) }) }

reps = File.readlines('input.txt').map { _1.split.map(&:to_i) }
reps += reps.map(&:reverse)

res = reps.group_by { good(_1) }

# a
p res[true].size


# b
p res[true].size + res[false].count { good_sans_1(_1) }
