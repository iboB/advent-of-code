lines = File.readlines('input.txt')
mt = lines[0].to_i
bts = lines[1].split(',').map(&:to_i).select { |i| i != 0 }
res = bts.map { |bt| ((mt + bt - 1) / bt) * bt }.each_with_index.min
p (res[0] - mt) * bts[res[1]]
