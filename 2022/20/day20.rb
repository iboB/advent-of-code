def shuffle(ar)
  ar.length.times do |i|
    ri = ar.index { _1[1] == i}
    rj = ar[ri][0]
    d = ar.delete_at(ri)
    rj += ri
    rj %= ar.size
    rj = -1 if rj == 0
    ar.insert(rj, d)
  end
end

def result(ar)
  zero = ar.index { _1[0] == 0 }
  [1000, 2000, 3000].map { ar[(zero + _1) % ar.size][0] }.sum
end

input = File.readlines('input.txt').map.with_index { |l, i|
  [l.strip.to_i, i]
}

# a
a = input.dup
shuffle(a)
p result(a)

# b
b = input.map { |a, i|
  [a * 811589153, i]
}
10.times { shuffle(b) }
p result b
