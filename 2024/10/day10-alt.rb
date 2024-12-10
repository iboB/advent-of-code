# combined bfs solution for a anb b

# every time I think of something clever with dfs for a, I have to rewrite it with bfs for b
# :(

Dirs = [-1, 1i, 1, -1i]

map = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    [x+y.i, c.to_i]
  }
}.to_h

p map.select { _2 == 0 }.map { |start, _|
  layer = {start => 1}
  (1..9).each { |h|
    layer = Hash.new(0).tap { |next_layer|
      layer.each { |cur_pos, n|
        Dirs.each { |dir|
          pos = cur_pos + dir
          next_layer[pos] += n if map[pos] == h
        }
      }
    }
  }
  #    a               b
  [layer.length, layer.sum { _2 }]
}.transpose.map(&:sum)



