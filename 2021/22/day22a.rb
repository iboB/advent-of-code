# just brute force

class Range
  def &(other)
    return nil if (self.max < other.begin or other.max < self.begin)
    [self.begin, other.begin].max..[self.max, other.max].min
  end
end

ls = {}
main = [-50..50, -50..50, -50..50]

input = File.readlines('input.txt').map { |l|
  s = l.strip.split(/,|\s/)
  val = s[0] == 'on'
  box = s[1..].map { |r| eval(r.split('=')[1]) }
  i = main.zip(box).each.map { _1 & _2 }.compact
  next if i.size != 3
  i[2].each do |z|
    i[1].each do |y|
      i[0].each do |x|
        if val
          ls[[x,y,z]] = true
        else
          ls.delete [x,y,z]
        end
      end
    end
  end
}

p ls.length
