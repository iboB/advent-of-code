rel = {}
File.readlines('input.txt').map { |l|
  ar = l.strip.chop.split(' ')
  name = ar[0]
  rel[name] = {} if !rel[name]
  val = ar[3].to_i
  val *= -1 if ar[2] == 'lose'
  rel[name][ar[-1]] = val
}

solve = ->() {
  rel.keys.permutation.map { |perm|
    perm << perm[0]
    perm.each_cons(2).inject(0) { |sum, pair|
      a, b = pair
      sum + rel[a][b] + rel[b][a]
    }
  }.max
}

# a
p solve.()

rel.each { |k, v| v['myself'] = 0 }
rel['myself'] = rel.keys.map { [_1, 0] }.to_h

# b
p solve.()
