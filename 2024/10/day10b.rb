Dirs = [-1, 1i, 1, -1i]

valleys = []

map = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    pos = x+y.i
    c = c.to_i
    valleys << pos if c == 0
    [pos, c]
  }
}.to_h

p valleys.sum { |start|
  layer = {start => 1}
  (1..9).each { |h|
    next_layer = Hash.new(0)
    layer.each { |cur_pos, n|
      Dirs.each { |dir|
        pos = cur_pos + dir
        next_layer[pos] += n if map[pos] == h
      }
    }
    layer = next_layer
  }
  layer.sum { _2 }
}



