ar = (1..3004953).to_a

while ar.length != 1
  odd = ar.length.odd?
  ar = ar.each_slice(2).map(&:first)
  ar.unshift ar.pop if odd
end

p ar[0]
