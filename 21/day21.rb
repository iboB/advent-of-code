input = File.readlines('input.txt').map { |line|
  line.strip!.chop!
  a, b = line.split('(contains ')
  [a.split(' '), b.split(', ')]
}

all = {}
hash = {}

input.each do |elem|
  elem[1].each do |a|
    if !hash.key?(a)
      hash[a] = elem[0]
    else
      hash[a] &= elem[0]
    end
  end
  elem[0].each do |i|
    all[i] = true
  end
end

alergs = {}
hash.each do |k, v|
  v.each do |i|
    alergs[i] = true
  end
end

noals = (all.keys - alergs.keys)

p input.each.map { |elem| (elem[0] & noals).length }.sum

solve = []

while true
  a, i = hash.find { |k, v| v.length == 1 }
  i = i[0]
  solve << [a, i]
  hash.delete(a)

  hash.each do |k, v|
    v.delete(i)
  end

  break if hash.length == 0
end

puts solve.sort { |a, b| a[0] <=> b[0] }.map { |x| x[1] }.join(',')