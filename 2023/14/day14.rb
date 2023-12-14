level = File.readlines('input.txt').map { |l|
  l.strip.chars
}

def fall(level)
  ret = level.transpose.map(&:reverse)
  ret.each do |col|
    (col.length-1).downto(0) do |i|
      next if col[i] != ?O
      j = i
      col[j-1..j] = [?., ?O] while col[j+=1] == ?.
    end
  end
  ret
end

def total_load(level)
  level.map { |col|
    col.map.with_index { |e, i|
      e == ?O ? i +1 : 0
    }.sum
  }.sum
end

# a
p total_load(fall(level))

# b
def cycle(level)
  4.times { level = fall(level) }
  level
end

# find cycle with
#
# h = Hash.new { |h, k| h[k] = [] }
# 200.times do |i|
#   level = cycle level
#   h[level.map(&:join).join] << i
# end
# p h.values
#
# then write at

def at(level, i)
  93.times { level = cycle level }
  i -= 93
  (i % 9).times { level = cycle level }
  level
end

level = at(level, 1000000000)
level = level.transpose.map(&:reverse) # make north west for total_load
p total_load(level)
