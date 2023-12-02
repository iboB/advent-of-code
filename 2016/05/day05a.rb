require 'digest'

IN = 'uqwqemis'
i = 0

out = ''

while out.length != 8
  h = Digest::MD5.hexdigest(IN + i.to_s)
  if h.start_with?('00000')
    out += h[5]
  end
  i += 1
end

p i
p out
