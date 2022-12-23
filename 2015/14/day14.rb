require 'matrix'

Secs = 2503
persec = File.readlines('input.txt').map { |l|
  speed, tmove, trest = l.scan(/\d+/).map(&:to_i)
  period = tmove + trest
  dpp = speed * tmove

  1.upto(Secs).map { |sec|
    div, mod = sec.divmod(period)
    dist = div * dpp
    mod = tmove if mod > tmove
    dist + speed * mod
  }
}.transpose

# part 1
p persec[-1].max

# part 2
p persec.map { |round|
  Vector[*round.map { _1 / round.max }]
}.inject(:+).to_a.max



