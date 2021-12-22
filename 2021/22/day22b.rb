# pretty slow (8 secs on the puzzle input)
# can be optimized a lot with allocation management
# no idea for algorithmic level optimizations (yet)
class Range
  def &(other)
    return nil if (self.max < other.begin or other.max < self.begin)
    [self.begin, other.begin].max..[self.max, other.max].min
  end
end

def i3(a, b)
  ret = []
  3.times do |n|
    i = a[n] & b[n]
    return nil if !i
    ret << i
  end
  ret
end

def vol(a)
  a.map { _1.size }.inject(&:*)
end

work = []

File.readlines('input.txt').map { |l|
  step = l.strip.split(/,|\s/).yield_self { |s|
    [s[0] == 'on' ? 1 : -1, s[1..].map { |r| eval(r.split('=')[1]) }]
  }

  news = []
  work.each do |w|
    i = i3(step[1], w[1])
    news << [-step[0] * step[0] * w[0], i] if i
  end
  work << step if step[0] > 0
  work += news
}

p work.map { |w, r| w * vol(r) }.sum
