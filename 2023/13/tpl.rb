require 'matrix'

class Array
  def find_mirror
    (1...self.length-1).each do |i|
      short, long = [self[...i].reverse, self[i..]].sort_by(&:length)
      long = long[...short.length]
      return i if long == short
    end
    0
  end
end

p File.read('input.txt').split("\n\n").map { |block|
  Matrix.rows block.lines.map { |l|
    l.strip.chars.map { _1 == ?# ? 1 : 0 }
  }
}.map { |m|
  v = m.column_count.times.map { m.column(_1) }.map { _1.to_a.join.to_i(2) }.find_mirror
  v += 100 * m.row_count.times.map { m.row(_1) }.map { _1.to_a.join.to_i(2) }.find_mirror
  puts m if v == 0
  v
}.sum
