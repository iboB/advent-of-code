class Array
  def find_mirror
    (1...self.length).each do |i|
      short, long = [self[...i].reverse, self[i..]].sort_by(&:length)
      long = long[...short.length]
      return i if long == short
    end
    0
  end
  def find_smudged_mirror
    (1...self.length).each do |i|
      short, long = [self[...i].reverse, self[i..]].sort_by(&:length)
      long = long[...short.length]
      diffs = long.zip(short).map { _1 ^ _2 } - [0]
      next if diffs.length != 1
      return i if diffs[0] & (diffs[0]-1) == 0
    end
    0
  end
end

rows, srows, cols, scols = File.read('input.txt').split("\n\n").map { |block|
  block.lines.map { |l|
    l.strip.chars.map { _1 == ?# ? 1 : 0 }
  }.yield_self {
    [_1, _1.transpose]
  }.map { |m|
    m.map { _1.join.to_i(2) }
  }.flat_map {
    [_1.find_mirror, _1.find_smudged_mirror]
  }
}.transpose.map(&:sum)

p cols + 100*rows
p scols + 100*srows
