require 'digest'

IN = 'yzbqklnj'

def findz(n)
  i = 0
  while Digest::MD5.hexdigest(IN + i.to_s)[0...n] != '0' * n
    i += 1
  end
  i
end

# a
p fincz(5)

# b
p findz(6)
