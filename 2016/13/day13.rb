require 'matrix'
Fav = 1364

Dirs = [[-1, 0], [0, -1], [0, 1], [1, 0]].map { |x, y| Vector[x, y] }

class Integer
  def popcnt
    n = self
    bits = 0
    while n != 0
      d, m = n.divmod(2)
      bits += m
      n = d
    end
    bits
  end
end

map = Hash.new { |h, k|
  x, y = k.to_a
  num = x*x + 3*x + 2*x*y + y + y*y + Fav
  h[k] = num.popcnt.even?
}

def bfs(map, q)
  start = Vector[1, 1]
  visited = Hash.new { |h, k|
    x, y = k.to_a
    next true if x < 0
    next true if y < 0
    false
  }
  visited[start] = true
  b = [start]

  (1..).each do |step|
    newb = []
    b.each do |pos|
      Dirs.each do |dir|
        newpos = pos + dir
        next if visited[newpos]
        next if !map[newpos]
        return step if newpos == q
        visited[newpos] = true
        newb << newpos
      end
    end
    b = newb
    if step == 50
      puts "b: #{visited.length}"
    end
  end
end

# a
puts "a: #{bfs(map, Vector[31, 39])}"
