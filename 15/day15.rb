ind = [0,1,4,13,15,12,16].each_with_index.to_a.to_h
len = ind.length
nn = 0

N = 30_000_000
(N-len-1).times do |x|
  i = ind[nn]
  ind[nn] = len
  nn = i ? len - i : 0
  len += 1
end

p nn
