require 'digest'

IN = 'uqwqemis'
i = 0

out = ' ' * 8

while true
  h = Digest::MD5.hexdigest(IN + i.to_s)
  i += 1
  next if !h.start_with?('00000')
  next if h[5] !~ /[0-7]/
  h5i = h[5].to_i
  next if out[h5i] != ' '
  out[h5i] = h[6]
  break if out !~ /\s/
end

p i
p out
