cs = File.readlines(?i).map { _1.split(?,).map(&:to_i) }

js = cs.each_with_index.to_a.combination(2).map { |(c0, i0), (c1, i1)|
  [i0, i1, c0.zip(c1).map { (_1 - _2).abs ** 2 }.sum]
}.sort_by(&:last)

groups = [nil] * cs.size

(1..).each { |i|
  i0, i1, _ = js.shift
  g0 = groups[i0]
  g1 = groups[i1]
  if g0 && g1
    next if g0 == g1
    groups.map! { _1 == g1 ? g0 : _1 }
  elsif g0
    groups[i1] = g0
  elsif g1
    groups[i0] = g1
  else
    groups[i0] = i
    groups[i1] = i
  end

  # a
  p groups.compact.tally.values.sort[-3..].inject(:*) if i == 1000

  # b
  break p cs[i0][0] * cs[i1][0] if groups.uniq.size == 1
}
