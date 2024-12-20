start = finish = nil

walls = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    pos = x + y.i
    start = pos if c == ?S
    finish = pos if c == ?E
    pos if c == ?#
  }.compact
}.to_set

@path = [start]

until @path.last == finish
  [1, -1, 1i, -1i].each { |d|
    next_pos = @path.last + d
    next if next_pos == @path[-2]
    next if walls === next_pos
    @path << next_pos
    break
  }
end

# count each pair of path points:
# * more then min_save steps apart
# * find manhattan distance between them and if it's less than max_md...
# * count them if moving through walls saves at least min_save steps
def solve(max_md, min_save)
  @path.each_index.sum { |ai|
    ((ai + min_save)...@path.size).count { |bi|
      a, b = @path[ai], @path[bi]
      md = (a.real - b.real).abs + (a.imag - b.imag).abs
      md <= max_md && bi - ai - md >= min_save
    }
  }
end

p solve(2, 100) # a
p solve(20, 100) # b
