
ar = [0,1,4,13,15,12,16]
ind = ar.each_with_index.to_a.to_h
len = ind.length
nn = 0

N = 30_000_000
(N-len-1).times do |x|
  i = ind[nn]
  if !i
    ind[nn] = len
    nn = 0
  else
    ind[nn] = len
    nn = len - i
  end
  len += 1
end

p nn