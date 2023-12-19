class Range
  def &(other)
    rmin = [self.min, other.min].max
    rmax = [self.max, other.max].min
    return nil if rmin > rmax
    rmin..rmax
  end
  def -(other)
    i = self & other
    return self if !i
    ret = []
    ret << (self.min..i.min-1) if self.min < i.min
    ret << (i.max+1..self.max) if self.max > i.max
    ret
  end
end

Flows = File.read('input.txt').split("\n\n")[0].lines.map { |f|
  f =~ /([a-z]+)\{(.+)\}/
  # [$1, $2]
  [$1, $2.split(?,).map { _1.split(':') }.map { |q, t|
    next q if !t
    lim = q[2..].to_i
    q[1] == ?> ? [q[0], lim+1..4000, t] : [q[0], 1..lim-1, t]
  }]
}.to_h

ACC = []

def solve(flow, ranges)
  return if flow == ?R
  return ACC << ranges if flow == ?A
  Flows[flow][..-2].each do |q, qr, t|
    solve(t, ranges.merge(q => ranges[q].map { _1 & qr }.compact))
    ranges = ranges.merge(q => ranges[q].map { _1 - qr }.flatten)
  end
  solve(Flows[flow][-1], ranges)
end

solve 'in', 'xmas'.chars.map { [_1, [1..4000]] }.to_h

p ACC.sum { |r|
    r.values.map { _1.sum(&:size) }.inject(&:*)
}
