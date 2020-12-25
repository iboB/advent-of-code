input = File.read('input.txt').split("\n\n")
ranges = input[0].split("\n").map { |l|
  l =~ /^[a-z ]+: (.+)$/
  $1.split(' or ').map { |r| r.split('-').map(&:to_i) }.map { |r| (r[0]..r[1]) }
}.to_h

tickets = input[2].lines[1..].map { |l| l.split(',').map(&:to_i) }

# A
p tickets.map { |t|
  t.select { |n|
    ranges.none? { |pair|
      pair.any? { |r| r === n }
    }
  }.sum
}.sum

# B
tickets.select! { |t|
  t.all? { |n|
    ranges.any? { |pair|
      pair.any? { |r| r === n }
    }
  }
}

myt = input[1].lines[1].split(',').map(&:to_i)
tickets << myt
matches = ranges.map { |r|
  (0...myt.length).select { |col|
    tickets.all? { |t|
      r.any? { |r| r === t[col] }
    }
  }
}

cmap = [nil] * myt.length
myt.length.times do
  singlei = matches.index { |m| m.length == 1}
  col = matches[singlei][0]
  cmap[singlei] = col
  matches.each { |m| m.delete(col) }
end

p cmap[0..5].map { |i| myt[i] }.inject(&:*)
