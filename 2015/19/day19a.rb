input = File.readlines('input.txt').map(&:strip)

target = input[-1]
reps =  input[0..-3].map { _1.split(' => ') }

# a
p reps.map { |from, to|
  target.enum_for(:scan, from).map {
    b, e = Regexp.last_match.offset(0)
    b...e
  }.map { |range|
    d = target.dup
    d[range] = to
    d
  }.to_a
}.flatten.uniq.length
