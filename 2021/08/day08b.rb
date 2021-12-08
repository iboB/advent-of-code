PerDigit = %w(abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg)
Eight = PerDigit[8].split(//)
Combos = PerDigit.map { |s| s.split(//).map { _1.ord - 'a'.ord } }

Perms = (0...7).to_a.permutation.map { |perm|
  Combos.map { |c| c.map { |i| Eight[perm[i]] }.sort.join }
}

def solve(keys, target)
  keys += target # target can be useful too as it also contains valid entries
  keys.map! { _1.split(//).sort.join }.uniq!

  found = Perms.detect { (keys - _1).empty? }

  raise 'uh-oh' if !found

  target.map { found.index _1.split(//).sort.join }.join.to_i
end

p File.readlines('input.txt').map { |l|
  solve(*l.strip.split(' | ').map(&:split))
}.sum
