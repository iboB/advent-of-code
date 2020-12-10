input = File.readlines('input.txt').map(&:to_i)

diffs = input.unshift(0).sort.each_cons(2).map { |a,b| b-a }

p diffs.count(1) * (diffs.count(3) + 1)
