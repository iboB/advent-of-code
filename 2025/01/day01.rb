hits = File.readlines(?i).inject([50]) { _1 << _1[-1] + _2.tr('LR', '-+').to_i }

# a
p a = hits.count { _1 % 100 == 0 }

# b
p hits.each_cons(2).map(&:sort).map { _2 / 100 - (_1 - 1) / 100 }.sum - a
