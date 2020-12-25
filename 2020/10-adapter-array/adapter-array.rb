input = File.readlines('input.txt').map(&:to_i)

diffs = input.sort.unshift(0).each_cons(2).map { |a,b| b-a }

p diffs.count(1) * (diffs.count(3) + 1)

# https://oeis.org/A003945
p diffs.chunk(&:itself).map { |n,ns| (3 * 2**(ns.length-3)).to_i + 1 if n == 1 }.compact.inject(&:*)
