d = {}
input = File.readlines('input.txt').map { |l|
  l =~ /(\w+) to (\w+) = (\d+)/
  a, b, dist = [$1, $2, $3.to_i]
  d[a] = Hash.new if !d[a]
  d[b] = Hash.new if !d[b]
  d[a][b] = dist
  d[b][a] = dist
}

all = d.keys.permutation.map { _1.each_cons(2).map { |a, b| d[a][b] }.sum }

# a
p all.min

# b
p all.max

