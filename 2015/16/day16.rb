QQQ = <<QQQ
children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1
QQQ

query = QQQ.strip.lines.map { |l|
  name, num = l.split(': ')
  [name, num.to_i]
}

File.readlines('input.txt').map.with_index { |l, i|
  sue = l.strip.scan(/\w+/)[2..].each_slice(2).map { |name, num|
    [name, num.to_i]
  }
  p i+1 if (sue - query).empty?
}


